function twiddle_stage_2_init(blk, varargin)

  clog('entering twiddle_coeff_0_init',{'trace', 'twiddle_stage_2_init_debug'});

  defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', '5', ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'floating_point', 'off', ...
    'float_type', 'single', ...
    'exp_width', 8, ...
    'frac_width', 24, ...      
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 2, ...
    'async', 'off'};

  if same_state(blk, 'defaults', defaults, varargin{:}), return, end
  check_mask_type(blk, 'twiddle_stage_2');
  munge_block(blk, varargin{:});

  delete_lines(blk);

  n_inputs        = get_var('n_inputs', 'defaults', defaults, varargin{:});
  FFTSize         = get_var('FFTSize', 'defaults', defaults, varargin{:});
  input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
  bin_pt_in       = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
  floating_point  = get_var('floating_point', 'defaults', defaults, varargin{:});
  float_type      = get_var('float_type', 'defaults', defaults, varargin{:});
  exp_width       = get_var('exp_width', 'defaults', defaults, varargin{:});
  frac_width      = get_var('frac_width', 'defaults', defaults, varargin{:});    
  add_latency     = get_var('add_latency', 'defaults', defaults, varargin{:});
  bram_latency    = get_var('bram_latency', 'defaults', defaults, varargin{:});
  mult_latency    = get_var('mult_latency', 'defaults', defaults, varargin{:});
  conv_latency    = get_var('conv_latency', 'defaults', defaults, varargin{:});
  async           = get_var('async', 'defaults', defaults, varargin{:});

  if n_inputs == 0,
    clean_blocks(blk);
    save_state(blk, 'defaults', defaults, varargin{:});
    clog('exiting twiddle_stage_2_init', {'trace', 'twiddle_stage_2_init_debug'});
    return;
  end

  if floating_point
    float_en = 'on';
    conv_latency = 0;
  else
    float_en = 'off';  
  end

  if float_type == 2
    float_type_sel = 'custom';
  else
    float_type_sel = 'single';
    exp_width = 8;
    frac_width = 24;
  end
  
  reuse_block(blk, 'ai', 'built-in/Inport');
  set_param([blk,'/ai'], ...
          'Port', sprintf('1'), ...
          'Position', sprintf('[265 73 295 87]'));

  reuse_block(blk, 'bi', 'built-in/Inport');
  set_param([blk,'/bi'], ...
          'Port', sprintf('2'), ...
          'Position', sprintf('[15 218 45 232]'));

  reuse_block(blk, 'sync_in', 'built-in/Inport');
  set_param([blk,'/sync_in'], ...
          'Port', sprintf('3'), ...
          'Position', sprintf('[205 403 235 417]'));

  reuse_block(blk, 'munge_in', 'casper_library_flow_control/munge', ...
          'divisions', 'n_inputs*2', ...
          'div_size', 'repmat(input_bit_width, 1, n_inputs*2)', ...
          'order', '[[0:2:(n_inputs-1)*2],[1:2:(n_inputs-1)*2+1]]', ...
          'Position', [70 214 110 236]);

  reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
          'mode', 'divisions of equal size', ...
          'outputNum', '2', ...
          'outputWidth', 'input_bit_width*n_inputs', ...
          'outputBinaryPt', '0', ...
          'outputArithmeticType', '0', ...
          'Position', [135 184 185 266]);

  reuse_block(blk, 'delay5', 'xbsIndex_r4/Delay');
  set_param([blk,'/delay5'], ...
          'latency', sprintf('bram_latency'), ...
          'reg_retiming', sprintf('on'), ...
          'Position', sprintf('[255 192 290 218]'));

      
  if floating_point
      reuse_block(blk, 'delay0', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay0'], ...
              'latency', sprintf('bram_latency+mult_latency+conv_latency+add_latency'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[325 67 360 93]'));
  else
      reuse_block(blk, 'delay0', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay0'], ...
              'latency', sprintf('bram_latency+mult_latency+conv_latency+add_latency'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[325 67 360 93]'));
  end    
 
  reuse_block(blk, 'delay6', 'xbsIndex_r4/Delay');
  set_param([blk,'/delay6'], ...
          'latency', sprintf('bram_latency'), ...
          'reg_retiming', sprintf('on'), ...
          'Position', sprintf('[255 282 290 308]'));

  reuse_block(blk, 'counter', 'xbsIndex_r4/Counter');
  set_param([blk,'/counter'], ...
          'n_bits', sprintf('FFTSize - 1 '), ...
          'rst', sprintf('on'), ...
          'en', async, ...
          'use_behavioral_HDL', sprintf('on'), ...
          'Position', sprintf('[350 223 390 267]'));

  reuse_block(blk, 'slice', 'xbsIndex_r4/Slice');
  set_param([blk,'/slice'], ...
          'Position', sprintf('[410 234 445 256]'));

  reuse_block(blk, 'delay7', 'xbsIndex_r4/Delay');
  set_param([blk,'/delay7'], ...
          'latency', sprintf('bram_latency'), ...
          'reg_retiming', sprintf('on'), ...
          'Position', sprintf('[260 397 295 423]'));

  if floating_point
      reuse_block(blk, 'negate', 'casper_library_bus/bus_negate', ...
              'n_bits_in', 'repmat(input_bit_width, 1, n_inputs)', ...
              'bin_pt_in', 'bin_pt_in', ...
              'floating_point', float_en, ...
              'float_type', float_type_sel, ...
              'exp_width', num2str(exp_width), ...
              'frac_width', num2str(frac_width), ...              
              'cmplx', 'off', 'misc', 'off', 'overflow', '1', ...
              'latency', '1+conv_latency', ...
              'Position', [245 333 310 357]);       
  else
      reuse_block(blk, 'negate', 'casper_library_bus/bus_negate', ...
              'n_bits_in', 'repmat(input_bit_width, 1, n_inputs)', ...
              'bin_pt_in', 'bin_pt_in', ...
              'floating_point', float_en, ...
              'float_type', float_type_sel, ...
              'exp_width', num2str(exp_width), ...
              'frac_width', num2str(frac_width), ...   
              'cmplx', 'off', 'misc', 'off', 'overflow', '1', ...
              'latency', '1+conv_latency', ...
              'Position', [245 333 310 357]);      
  end


  if floating_point
      reuse_block(blk, 'mux0', 'xbsIndex_r4/Mux');
      set_param([blk,'/mux0'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency'), ...
              'Position', sprintf('[565 175 590 235]'));

      reuse_block(blk, 'delay2', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay2'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency-1'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[525 296 565 314]'));

      reuse_block(blk, 'delay3', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay3'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency-1'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[525 316 565 334]'));  
  else
      reuse_block(blk, 'mux0', 'xbsIndex_r4/Mux');
      set_param([blk,'/mux0'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency'), ...
              'Position', sprintf('[565 175 590 235]'));

      reuse_block(blk, 'delay2', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay2'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency-1'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[525 296 565 314]'));

      reuse_block(blk, 'delay3', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay3'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency-1'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[525 316 565 334]'));      
  end


  reuse_block(blk, 'delay4', 'xbsIndex_r4/Delay');
  set_param([blk,'/delay4'], ...
          'latency', sprintf('bram_latency+mult_latency+add_latency-2'), ...
          'reg_retiming', sprintf('on'), ...
          'Position', sprintf('[525 336 565 354]'));

  if floating_point
      reuse_block(blk, 'delay8', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay8'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[525 397 560 423]'));

  else
      reuse_block(blk, 'delay8', 'xbsIndex_r4/Delay');
      set_param([blk,'/delay8'], ...
              'latency', sprintf('mult_latency+conv_latency+add_latency'), ...
              'reg_retiming', sprintf('on'), ...
              'Position', sprintf('[525 397 560 423]'));
  end

  reuse_block(blk, 'mux1', 'xbsIndex_r4/Mux');
  set_param([blk,'/mux1'], ...
          'latency', sprintf('1'), ...
          'Position', sprintf('[595 295 620 355]'));

  reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
          'inputNum', '2', ...
          'Position', [650 187 690 263]);

  reuse_block(blk, 'munge_out', 'casper_library_flow_control/munge', ...
          'divisions', 'n_inputs*2', ...
          'div_size', 'repmat(input_bit_width, 1, n_inputs*2)', ...
          'order', 'reshape([[0:(n_inputs-1)];[n_inputs:(n_inputs*2)-1]], 1, n_inputs*2)', ...
          'Position', [720 214 760 236]);

  reuse_block(blk, 'ao', 'built-in/Outport');
  set_param([blk,'/ao'], ...
          'Port', sprintf('1'), ...
          'Position', sprintf('[390 73 420 87]'));

  reuse_block(blk, 'bwo', 'built-in/Outport');
  set_param([blk,'/bwo'], ...
          'Port', sprintf('2'), ...
          'Position', sprintf('[785 218 815 232]'));

  reuse_block(blk, 'sync_out', 'built-in/Outport');
  set_param([blk,'/sync_out'], ...
          'Port', sprintf('3'), ...
          'Position', sprintf('[785 403 815 417]'));

  add_line(blk,'sync_in/1','delay7/1');
  add_line(blk,'bi/1','munge_in/1');
  add_line(blk,'ai/1','delay0/1');
  add_line(blk,'munge_in/1','bus_expand/1');
  add_line(blk,'bus_expand/2','delay6/1');
  add_line(blk,'bus_expand/1','delay5/1');
  add_line(blk,'bus_expand/1','negate/1');
  add_line(blk,'delay5/1','mux0/2');
  add_line(blk,'delay0/1','ao/1');
  add_line(blk,'delay6/1','mux0/3');
  add_line(blk,'delay6/1','delay3/1');
  add_line(blk,'counter/1','slice/1');
  add_line(blk,'slice/1','delay2/1');
  add_line(blk,'slice/1','mux0/1');
  add_line(blk,'delay7/1','counter/1');
  add_line(blk,'delay7/1','delay8/1');
  add_line(blk,'negate/1','delay4/1');
  add_line(blk,'mux0/1','bus_create/1');
  add_line(blk,'delay2/1','mux1/1');
  add_line(blk,'delay3/1','mux1/2');
  add_line(blk,'delay4/1','mux1/3');
  add_line(blk,'delay8/1','sync_out/1');
  add_line(blk,'mux1/1','bus_create/2');
  add_line(blk,'bus_create/1','munge_out/1');
  add_line(blk,'munge_out/1','bwo/1');
  
  if strcmp(async, 'on'),
    reuse_block(blk, 'dvi', 'built-in/Inport', ...
            'Port', '4', ...
            'Position', [50 496 80 514]);
    reuse_block(blk, 'delay1', 'xbsIndex_r4/Delay', ...
            'latency', 'bram_latency', ...
            'reg_retiming', 'on', ...
            'Position', [260 496 295 514]);
    add_line(blk, 'dvi/1', 'delay1/1');
    add_line(blk, 'delay1/1', 'counter/2');
    
    if floating_point
            reuse_block(blk, 'delay9', 'xbsIndex_r4/Delay', ...
            'latency', 'mult_latency+add_latency+conv_latency', ...
            'reg_retiming', 'on', ...
            'Position', [525 496 560 514]);
    else
            reuse_block(blk, 'delay9', 'xbsIndex_r4/Delay', ...
            'latency', 'mult_latency+add_latency+conv_latency', ...
            'reg_retiming', 'on', ...
            'Position', [525 496 560 514]);
    end
    
    add_line(blk, 'delay1/1', 'delay9/1');
    reuse_block(blk, 'dvo', 'built-in/Outport', ...
            'Port', '4', ...
            'Position', [785 498 815 512]);

    add_line(blk, 'delay9/1', 'dvo/1');
  end

  clean_blocks(blk);

  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_coeff_0_init', {'trace','twiddle_coeff_0_init_debug'});
end % twiddle_stage_2_init

