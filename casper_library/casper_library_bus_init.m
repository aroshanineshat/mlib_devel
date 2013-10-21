function casper_library_bus_init()

	warning off Simulink:Engine:MdlFileShadowing;
	mdl = new_system('casper_library_bus', 'Library');
	blk = get(mdl,'Name');
	warning on Simulink:Engine:MdlFileShadowing;

	add_block('built-in/SubSystem', [blk,'/bus_addsub']);
	bus_addsub_gen([blk,'/bus_addsub']);
	set_param([blk,'/bus_addsub'], ...
		'opmode', sprintf('0'), ...
		'n_bits_a', sprintf('0'), ...
		'bin_pt_a', sprintf('3'), ...
		'type_a', sprintf('1'), ...
		'n_bits_b', sprintf('4'), ...
		'bin_pt_b', sprintf('3'), ...
		'type_b', sprintf('1'), ...
		'cmplx', sprintf('on'), ...
		'misc', sprintf('on'), ...
		'async', sprintf('off'), ...
		'n_bits_out', sprintf('8'), ...
		'bin_pt_out', sprintf('3'), ...
		'type_out', sprintf('1'), ...
		'quantization', sprintf('0'), ...
		'overflow', sprintf('1'), ...
		'add_implementation', sprintf('fabric core'), ...
		'latency', sprintf('1'), ...
		'Position', sprintf('[20 17 95 93]'));

	add_block('built-in/SubSystem', [blk,'/bus_register']);
	bus_register_gen([blk,'/bus_register']);
	set_param([blk,'/bus_register'], ...
		'reset', sprintf('on'), ...
		'enable', sprintf('on'), ...
		'cmplx', sprintf('on'), ...
		'n_bits', sprintf('[]'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[120 17 195 93]'));

	add_block('built-in/SubSystem', [blk,'/bus_mux']);
	bus_mux_gen([blk,'/bus_mux']);
	set_param([blk,'/bus_mux'], ...
		'n_bits', sprintf('[]'), ...
		'mux_latency', sprintf('1'), ...
		'cmplx', sprintf('on'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[20 134 95 210]'));

	add_block('built-in/SubSystem', [blk,'/bus_mult']);
	bus_mult_gen([blk,'/bus_mult']);
	set_param([blk,'/bus_mult'], ...
		'n_bits_a', sprintf('0'), ...
		'bin_pt_a', sprintf('4'), ...
		'type_a', sprintf('1'), ...
		'cmplx_a', sprintf('on'), ...
		'n_bits_b', sprintf('4'), ...
		'bin_pt_b', sprintf('3'), ...
		'type_b', sprintf('1'), ...
		'cmplx_b', sprintf('on'), ...
		'n_bits_out', sprintf('12'), ...
		'bin_pt_out', sprintf('7'), ...
		'type_out', sprintf('1'), ...
		'quantization', sprintf('0'), ...
		'overflow', sprintf('0'), ...
		'mult_latency', sprintf('3'), ...
		'add_latency', sprintf('1'), ...
		'conv_latency', sprintf('1'), ...
		'max_fanout', sprintf('2'), ...
		'fan_latency', sprintf('0'), ...
		'multiplier_implementation', sprintf('behavioral HDL'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[120 132 195 208]'));

	add_block('built-in/SubSystem', [blk,'/bus_replicate']);
	bus_replicate_gen([blk,'/bus_replicate']);
	set_param([blk,'/bus_replicate'], ...
		'replication', sprintf('0'), ...
		'latency', sprintf('0'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[220 17 295 93]'));

	add_block('built-in/SubSystem', [blk,'/bus_logical']);
	bus_logical_gen([blk,'/bus_logical']);
	set_param([blk,'/bus_logical'], ...
		'logical_function', sprintf('AND'), ...
		'align_bp', sprintf('on'), ...
		'latency', sprintf('1'), ...
		'n_bits_a', sprintf('[]'), ...
		'bin_pt_a', sprintf('3'), ...
		'type_a', sprintf('1'), ...
		'n_bits_b', sprintf('4'), ...
		'bin_pt_b', sprintf('3'), ...
		'type_b', sprintf('1'), ...
		'cmplx', sprintf('on'), ...
		'en', sprintf('on'), ...
		'misc', sprintf('on'), ...
		'n_bits_out', sprintf('8'), ...
		'bin_pt_out', sprintf('3'), ...
		'type_out', sprintf('1'), ...
		'Position', sprintf('[20 252 95 328]'));

	add_block('built-in/SubSystem', [blk,'/bus_convert']);
	bus_convert_gen([blk,'/bus_convert']);
	set_param([blk,'/bus_convert'], ...
		'n_bits_in', sprintf('[]'), ...
		'bin_pt_in', sprintf('8'), ...
		'cmplx', sprintf('off'), ...
		'n_bits_out', sprintf('8'), ...
		'bin_pt_out', sprintf('4'), ...
		'quantization', sprintf('1'), ...
		'overflow', sprintf('1'), ...
		'latency', sprintf('2'), ...
		'of', sprintf('on'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[220 132 295 208]'));

	add_block('built-in/SubSystem', [blk,'/bus_negate']);
	bus_negate_gen([blk,'/bus_negate']);
	set_param([blk,'/bus_negate'], ...
		'n_bits_in', sprintf('0'), ...
		'bin_pt_in', sprintf('8'), ...
		'cmplx', sprintf('off'), ...
		'overflow', sprintf('1'), ...
		'latency', sprintf('2'), ...
		'misc', sprintf('off'), ...
		'Position', sprintf('[120 252 195 328]'));

	add_block('built-in/SubSystem', [blk,'/bus_accumulator']);
	bus_accumulator_gen([blk,'/bus_accumulator']);
	set_param([blk,'/bus_accumulator'], ...
		'reset', sprintf('on'), ...
		'enable', sprintf('on'), ...
		'n_bits_in', sprintf('[]'), ...
		'bin_pt_in', sprintf('3'), ...
		'type_in', sprintf('1'), ...
		'cmplx', sprintf('on'), ...
		'n_bits_out', sprintf('16'), ...
		'overflow', sprintf('1'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[320 17 395 93]'));

	add_block('built-in/SubSystem', [blk,'/bus_relational']);
	bus_relational_gen([blk,'/bus_relational']);
	set_param([blk,'/bus_relational'], ...
		'n_bits_a', sprintf('0'), ...
		'bin_pt_a', sprintf('0'), ...
		'type_a', sprintf('1'), ...
		'n_bits_b', sprintf('8'), ...
		'bin_pt_b', sprintf('0'), ...
		'type_b', sprintf('1'), ...
		'en', sprintf('off'), ...
		'misc', sprintf('off'), ...
		'mode', sprintf('a=b'), ...
		'latency', sprintf('1'), ...
		'Position', sprintf('[220 252 295 328]'));

	add_block('built-in/SubSystem', [blk,'/bus_scale']);
	bus_scale_gen([blk,'/bus_scale']);
	set_param([blk,'/bus_scale'], ...
		'n_bits_in', sprintf('[]'), ...
		'bin_pt_in', sprintf('8'), ...
		'type_in', sprintf('1'), ...
		'cmplx', sprintf('off'), ...
		'scale_factor', sprintf('2'), ...
		'misc', sprintf('on'), ...
		'Position', sprintf('[320 132 395 208]'));

	add_block('built-in/SubSystem', [blk,'/bus_single_port_ram']);
	bus_single_port_ram_gen([blk,'/bus_single_port_ram']);
	set_param([blk,'/bus_single_port_ram'], ...
		'n_bits', sprintf('0'), ...
		'bin_pts', sprintf('17'), ...
		'init_vector', sprintf('[[-2:1/(2^3):2-(1/(2^3))]'']'), ...
		'max_fanout', sprintf('4'), ...
		'mem_type', sprintf('Block RAM'), ...
		'async', sprintf('off'), ...
		'misc', sprintf('off'), ...
		'bram_latency', sprintf('2'), ...
		'fan_latency', sprintf('1'), ...
		'addr_register', sprintf('on'), ...
		'din_register', sprintf('on'), ...
		'we_register', sprintf('on'), ...
		'en_register', sprintf('on'), ...
		'Position', sprintf('[20 372 95 448]'));

	add_block('built-in/SubSystem', [blk,'/bus_maddsub']);
	bus_maddsub_gen([blk,'/bus_maddsub']);
	set_param([blk,'/bus_maddsub'], ...
		'n_bits_a', sprintf('0'), ...
		'bin_pt_a', sprintf('7'), ...
		'type_a', sprintf('1'), ...
		'cmplx_a', sprintf('on'), ...
		'n_bits_b', sprintf('[18 18]'), ...
		'bin_pt_b', sprintf('17'), ...
		'type_b', sprintf('1'), ...
		'mult_latency', sprintf('3'), ...
		'multiplier_implementation', sprintf('behavioral HDL'), ...
		'replication_ab', sprintf('on'), ...
		'opmode', sprintf('Addition'), ...
		'n_bits_c', sprintf('[4 4 4 4]'), ...
		'bin_pt_c', sprintf('3'), ...
		'type_c', sprintf('0'), ...
		'add_implementation', sprintf('behavioral HDL'), ...
		'add_latency', sprintf('1'), ...
		'async_add', sprintf('on'), ...
		'align_c', sprintf('off'), ...
		'replication_c', sprintf('off'), ...
		'n_bits_out', sprintf('26'), ...
		'bin_pt_out', sprintf('24'), ...
		'type_out', sprintf('1'), ...
		'quantization', sprintf('0'), ...
		'overflow', sprintf('0'), ...
		'max_fanout', sprintf('2'), ...
		'Position', sprintf('[120 371 195 449]'));

	add_block('built-in/SubSystem', [blk,'/bus_dual_port_ram']);
	bus_dual_port_ram_gen([blk,'/bus_dual_port_ram']);
	set_param([blk,'/bus_dual_port_ram'], ...
		'n_bits', sprintf('0'), ...
		'bin_pts', sprintf('17'), ...
		'init_vector', sprintf('[[-2:1/(2^3):2-(1/(2^3))]'']'), ...
		'max_fanout', sprintf('4'), ...
		'mem_type', sprintf('Block RAM'), ...
		'async_a', sprintf('off'), ...
		'async_b', sprintf('off'), ...
		'misc', sprintf('off'), ...
		'bram_latency', sprintf('2'), ...
		'fan_latency', sprintf('1'), ...
		'Position', sprintf('[320 252 395 328]'));

	set_param(blk, ...
		'Name', sprintf('casper_library_bus'), ...
		'LibraryType', sprintf('BlockLibrary'), ...
		'Lock', sprintf('off'), ...
		'PreSaveFcn', sprintf('mdl2m(gcs, ''library'', ''on'');'), ...
		'SolverName', sprintf('ode45'), ...
		'SolverMode', sprintf('Auto'), ...
		'StartTime', sprintf('0.0'), ...
		'StopTime', sprintf('10.0'));
	save_system(mdl,[getenv('MLIB_DEVEL_PATH'), '/casper_library/', 'casper_library_bus']);
end % casper_library_bus_init

function bus_addsub_gen(blk)

	bus_addsub_mask(blk);
	bus_addsub_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_addsub_init(gcb, ...\n    ''opmode'', opmode, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''overflow'', overflow, ...        \n    ''quantization'', quantization, ...\n    ''add_implementation'', add_implementation, ...\n    ''latency'', latency, ...\n    ''cmplx'', cmplx, ...\n    ''misc'', misc, ...\n    ''async'', async);'));

end % bus_addsub_gen

function bus_addsub_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_addsub'), ...
		'MaskDescription', sprintf('Add/subtract components of two busses'), ...
		'MaskPromptString', sprintf('mode (Addition=0, Subtraction=1)|a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|complex|misc support|asynchronous operation|output bit widths|output binary points|output type (Unsigned=0, Signed=1)|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|adder implementation|latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,edit,checkbox,checkbox,checkbox,edit,edit,edit,edit,edit,popup(behavioral HDL|fabric core|DSP48 core),edit'), ...
		'MaskTabNameString', sprintf('input,input,input,input,input,input,input,input,input,input,output,output,output,implementation,implementation,implementation,latency'), ...
		'MaskCallbackString', sprintf('||||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('opmode=@1;n_bits_a=@2;bin_pt_a=@3;type_a=@4;n_bits_b=@5;bin_pt_b=@6;type_b=@7;cmplx=&8;misc=&9;async=&10;n_bits_out=@11;bin_pt_out=@12;type_out=@13;quantization=@14;overflow=@15;add_implementation=&16;latency=@17;'), ...
		'MaskValueString', sprintf('0|0|3|1|4|3|1|on|on|off|8|3|1|0|1|fabric core|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_addsub_mask

function bus_addsub_init(blk)

end % bus_addsub_init

function bus_register_gen(blk)

	bus_register_mask(blk);
	bus_register_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_register_init(gcb, ...\n    ''reset'', reset, ...\n    ''enable'', enable, ...\n    ''cmplx'', cmplx, ...\n    ''n_bits'', n_bits, ...\n    ''misc'', misc);'));

end % bus_register_gen

function bus_register_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_register'), ...
		'MaskDescription', sprintf('Register components of bus'), ...
		'MaskPromptString', sprintf('reset port|enable port|complex data|input bit widths|misc support'), ...
		'MaskStyleString', sprintf('checkbox,checkbox,checkbox,edit,checkbox'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('reset=&1;enable=&2;cmplx=&3;n_bits=@4;misc=&5;'), ...
		'MaskValueString', sprintf('on|on|on|[]|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_register_mask

function bus_register_init(blk)

end % bus_register_init

function bus_mux_gen(blk)

	bus_mux_mask(blk);
	bus_mux_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_mux_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''cmplx'', cmplx, ...\n    ''misc'', misc, ...\n    ''mux_latency'', mux_latency);'));

end % bus_mux_gen

function bus_mux_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_mux'), ...
		'MaskDescription', sprintf('Mux components of bus'), ...
		'MaskPromptString', sprintf('input bit widths|mux latency|complex data|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,checkbox,checkbox'), ...
		'MaskTabNameString', sprintf('input,latency,input,input'), ...
		'MaskCallbackString', sprintf('|||'), ...
		'MaskEnableString', sprintf('on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;mux_latency=@2;cmplx=&3;misc=&4;'), ...
		'MaskValueString', sprintf('[]|1|on|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_mux_mask

function bus_mux_init(blk)

end % bus_mux_init

function bus_mult_gen(blk)

	bus_mult_mask(blk);
	bus_mult_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_mult_init(gcb, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''cmplx_a'', cmplx_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''cmplx_b'', cmplx_b, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''quantization'', quantization, ...\n    ''overflow'', overflow, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''conv_latency'', conv_latency, ...\n    ''max_fanout'', max_fanout, ...\n    ''fan_latency'', fan_latency, ...\n    ''multiplier_implementation'', multiplier_implementation, ...\n    ''misc'', misc);'));

end % bus_mult_gen

function bus_mult_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_mult'), ...
		'MaskDescription', sprintf('Multiply components of two busses'), ...
		'MaskPromptString', sprintf('a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|a input complex|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|b input complex|output bit widths|output binary points|output type (Unsigned=0, Signed=1)|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|multiplier latency|adder latency|convert latency|limit fanout to ?|fanout register latency|multiplier implementation|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,edit,checkbox,edit,edit,edit,checkbox,edit,edit,edit,edit,edit,edit,edit,edit,edit,edit,popup(behavioral HDL|standard core|embedded multiplier core),checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,input,input,input,input,input,output,output,output,output,output,latency,latency,latency,implementation,implementation,implementation,input'), ...
		'MaskCallbackString', sprintf('|||||||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_a=@1;bin_pt_a=@2;type_a=@3;cmplx_a=&4;n_bits_b=@5;bin_pt_b=@6;type_b=@7;cmplx_b=&8;n_bits_out=@9;bin_pt_out=@10;type_out=@11;quantization=@12;overflow=@13;mult_latency=@14;add_latency=@15;conv_latency=@16;max_fanout=@17;fan_latency=@18;multiplier_implementation=&19;misc=&20;'), ...
		'MaskValueString', sprintf('0|4|1|on|4|3|1|on|12|7|1|0|0|3|1|1|2|0|behavioral HDL|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_mult_mask

function bus_mult_init(blk)

end % bus_mult_init

function bus_replicate_gen(blk)

	bus_replicate_mask(blk);
	bus_replicate_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_replicate_init(gcb, ...\n    ''replication'', replication, ...\n    ''latency'', latency, ...\n    ''misc'', misc);'));

end % bus_replicate_gen

function bus_replicate_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_replicate'), ...
		'MaskDescription', sprintf('Output bus formed by replicating input bus a number of times'), ...
		'MaskPromptString', sprintf('replication factor|latency|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,checkbox'), ...
		'MaskCallbackString', sprintf('||'), ...
		'MaskEnableString', sprintf('on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on'), ...
		'MaskVariables', sprintf('replication=@1;latency=@2;misc=&3;'), ...
		'MaskValueString', sprintf('0|0|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_replicate_mask

function bus_replicate_init(blk)

end % bus_replicate_init

function bus_logical_gen(blk)

	bus_logical_mask(blk);
	bus_logical_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_logical_init(gcb, ...\n    ''logical_function'', logical_function, ...\n    ''en'', en, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''latency'', latency, ...\n    ''cmplx'', cmplx, ...\n    ''align_bp'', align_bp, ...\n    ''misc'', misc);'));

end % bus_logical_gen

function bus_logical_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_logical'), ...
		'MaskDescription', sprintf('Form the logical product of two busses'), ...
		'MaskPromptString', sprintf('logical function|align binary point|latency|a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|complex|en port|misc support|output bit widths|output binary points|output type (Unsigned=0, Signed=1)'), ...
		'MaskStyleString', sprintf('popup(AND|NAND|OR|NOR|XOR|XNOR),checkbox,edit,edit,edit,edit,edit,edit,edit,checkbox,checkbox,checkbox,edit,edit,edit'), ...
		'MaskTabNameString', sprintf('operation,operation,operation,input,input,input,input,input,input,input,input,input,output,output,output'), ...
		'MaskCallbackString', sprintf('||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('logical_function=&1;align_bp=&2;latency=@3;n_bits_a=@4;bin_pt_a=@5;type_a=@6;n_bits_b=@7;bin_pt_b=@8;type_b=@9;cmplx=&10;en=&11;misc=&12;n_bits_out=@13;bin_pt_out=@14;type_out=@15;'), ...
		'MaskValueString', sprintf('AND|on|1|[]|3|1|4|3|1|on|on|on|8|3|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_logical_mask

function bus_logical_init(blk)

end % bus_logical_init

function bus_convert_gen(blk)

	bus_convert_mask(blk);
	bus_convert_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_convert_init(gcb, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''cmplx'', cmplx, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''quantization'', quantization, ...\n    ''overflow'', overflow, ...\n    ''latency'', latency, ...\n    ''misc'', misc, ...\n    ''of'', of);'));

end % bus_convert_gen

function bus_convert_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_convert'), ...
		'MaskDescription', sprintf('Convert components of busses'), ...
		'MaskPromptString', sprintf('input bit widths|input binary points |input complex|output bit widths|output binary points|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1, Round (unbiased: Even Values)=2)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|latency|overflow indication|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,checkbox,edit,edit,edit,edit,edit,checkbox,checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,output,output,output,output,operation,operation,input'), ...
		'MaskCallbackString', sprintf('|||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_in=@1;bin_pt_in=@2;cmplx=&3;n_bits_out=@4;bin_pt_out=@5;quantization=@6;overflow=@7;latency=@8;of=&9;misc=&10;'), ...
		'MaskValueString', sprintf('[]|8|off|8|4|1|1|2|on|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_convert_mask

function bus_convert_init(blk)

end % bus_convert_init

function bus_negate_gen(blk)

	bus_negate_mask(blk);
	bus_negate_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_negate_init(gcb, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''cmplx'', cmplx, ...\n    ''overflow'', overflow, ...\n    ''latency'', latency, ...\n    ''misc'', misc);'));

end % bus_negate_gen

function bus_negate_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_negate'), ...
		'MaskDescription', sprintf('Negate components of busses'), ...
		'MaskPromptString', sprintf('input bit widths|input binary points |input complex|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|latency|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,checkbox,edit,edit,checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,operation,operation,input'), ...
		'MaskCallbackString', sprintf('|||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_in=@1;bin_pt_in=@2;cmplx=&3;overflow=@4;latency=@5;misc=&6;'), ...
		'MaskValueString', sprintf('0|8|off|1|2|off'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_negate_mask

function bus_negate_init(blk)

end % bus_negate_init

function bus_accumulator_gen(blk)

	bus_accumulator_mask(blk);
	bus_accumulator_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_accumulator_init(gcb, ...\n    ''reset'', reset, ...\n    ''enable'', enable, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''type_in'', type_in, ...\n    ''cmplx'', cmplx, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''overflow'', overflow, ...\n    ''misc'', misc);'));

end % bus_accumulator_gen

function bus_accumulator_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_accumulator'), ...
		'MaskDescription', sprintf('Accumulate components of bus'), ...
		'MaskPromptString', sprintf('reset port|enable port|input bit widths|input binary points|input types (Unsigned=0, Signed=1)|complex inputs|output bit widths|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|misc support'), ...
		'MaskStyleString', sprintf('checkbox,checkbox,edit,edit,edit,checkbox,edit,edit,checkbox'), ...
		'MaskCallbackString', sprintf('||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('reset=&1;enable=&2;n_bits_in=@3;bin_pt_in=@4;type_in=@5;cmplx=&6;n_bits_out=@7;overflow=@8;misc=&9;'), ...
		'MaskValueString', sprintf('on|on|[]|3|1|on|16|1|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_accumulator_mask

function bus_accumulator_init(blk)

end % bus_accumulator_init

function bus_relational_gen(blk)

	bus_relational_mask(blk);
	bus_relational_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_relational_init(gcb, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''en'', en, ...\n    ''misc'', misc, ...\n    ''mode'', mode, ...\n    ''latency'', latency);'));

end % bus_relational_gen

function bus_relational_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_relational'), ...
		'MaskDescription', sprintf('Find the relational product of two busses'), ...
		'MaskPromptString', sprintf('a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|en port|misc support|comparison:|latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,checkbox,popup(a=b|a!=b|a<b|a>b|a<=b|a>=b),edit'), ...
		'MaskTabNameString', sprintf('input,input,input,input,input,input,input,input,operation,operation'), ...
		'MaskCallbackString', sprintf('|||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_a=@1;bin_pt_a=@2;type_a=@3;n_bits_b=@4;bin_pt_b=@5;type_b=@6;en=&7;misc=&8;mode=&9;latency=@10;'), ...
		'MaskValueString', sprintf('0|0|1|8|0|1|off|off|a=b|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_relational_mask

function bus_relational_init(blk)

end % bus_relational_init

function bus_scale_gen(blk)

	bus_scale_mask(blk);
	bus_scale_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_scale_init(gcb, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''type_in'', type_in, ...\n    ''cmplx'', cmplx, ...\n    ''scale_factor'', scale_factor, ...\n    ''misc'', misc);'));

end % bus_scale_gen

function bus_scale_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_scale'), ...
		'MaskDescription', sprintf('Convert components of busses'), ...
		'MaskPromptString', sprintf('input bit widths|input binary points |input types|input complex|scale factor (2^?)|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,edit,checkbox,edit,checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,input,output,input'), ...
		'MaskCallbackString', sprintf('|||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_in=@1;bin_pt_in=@2;type_in=@3;cmplx=&4;scale_factor=@5;misc=&6;'), ...
		'MaskValueString', sprintf('[]|8|1|off|2|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_scale_mask

function bus_scale_init(blk)

end % bus_scale_init

function bus_single_port_ram_gen(blk)

	bus_single_port_ram_mask(blk);
	bus_single_port_ram_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_single_port_ram_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''bin_pts'', bin_pts, ...\n    ''init_vector'', init_vector, ...\n    ''max_fanout'', max_fanout, ...\n    ''mem_type'', mem_type, ...\n    ''async'', async, ...\n    ''misc'', misc, ...\n    ''bram_latency'', bram_latency, ...\n    ''fan_latency'', fan_latency, ...\n    ''addr_register'', addr_register, ...\n    ''din_register'', din_register, ...\n    ''we_register'', we_register, ...\n    ''en_register'', en_register);'));

end % bus_single_port_ram_gen

function bus_single_port_ram_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_single_port_ram'), ...
		'MaskDescription', sprintf('RAM for a bus allowing fanout control'), ...
		'MaskPromptString', sprintf('data word bit widths|data word binary points|initial value vector|limit fanout to ?|memory type|asynchronous |misc support|bram latency|fanout register latency|addr input register|din input register|we input register|en input register'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,popup(Distributed memory|Block RAM),checkbox,checkbox,edit,edit,checkbox,checkbox,checkbox,checkbox'), ...
		'MaskTabNameString', sprintf('basic,basic,basic,basic,basic,basic,basic,latency,latency,latency,latency,latency,latency'), ...
		'MaskCallbackString', sprintf('||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;bin_pts=@2;init_vector=@3;max_fanout=@4;mem_type=&5;async=&6;misc=&7;bram_latency=@8;fan_latency=@9;addr_register=&10;din_register=&11;we_register=&12;en_register=&13;'), ...
		'MaskValueString', sprintf('0|17|[[-2:1/(2^3):2-(1/(2^3))]'']|4|Block RAM|off|off|2|1|on|on|on|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_single_port_ram_mask

function bus_single_port_ram_init(blk)

end % bus_single_port_ram_init

function bus_maddsub_gen(blk)

	bus_maddsub_mask(blk);
	bus_maddsub_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_maddsub_init(gcb, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''cmplx_a'', cmplx_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''mult_latency'', mult_latency, ...\n    ''multiplier_implementation'', multiplier_implementation, ...\n    ''replication_ab'', replication_ab, ...\n    ''opmode'', opmode, ...\n    ''n_bits_c'', n_bits_c, ...\n    ''bin_pt_c'', bin_pt_c, ...\n    ''type_c'', type_c, ...\n    ''add_implementation'', add_implementation, ...\n    ''add_latency'', add_latency, ...\n    ''async_add'', async_add, ...\n    ''align_c'', align_c, ...\n    ''replication_c'', replication_c, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''quantization'', quantization, ...\n    ''overflow'', overflow, ...\n    ''max_fanout'', max_fanout);'));

end % bus_maddsub_gen

function bus_maddsub_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_maddsub'), ...
		'MaskDescription', sprintf('Multiply and add/subtract components of two busses'), ...
		'MaskPromptString', sprintf('a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|a complex|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|multiplier latency|multiplier implementation|a and b input replication support|mode|c input bit widths|c input binary points|c input type (Unsigned=0, Signed=1)|adder implementation|adder latency|asynchronous addition|align c path with a and b|c input replication support|output bit widths|output binary points|output type (Unsigned=0, Signed=1)|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|limit fanout to ?'), ...
		'MaskStyleString', sprintf('edit,edit,edit,checkbox,edit,edit,edit,edit,popup(behavioral HDL|standard core|embedded multiplier core),checkbox,popup(Addition|Subtraction),edit,edit,edit,popup(behavioral HDL|fabric core|DSP48 core),edit,checkbox,checkbox,checkbox,edit,edit,edit,edit,edit,edit'), ...
		'MaskTabNameString', sprintf('multiplication,multiplication,multiplication,multiplication,multiplication,multiplication,multiplication,multiplication,multiplication,multiplication,addsub,addsub,addsub,addsub,addsub,addsub,addsub,addsub,addsub,output,output,output,output,output,implementation'), ...
		'MaskCallbackString', sprintf('||||||||||||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_a=@1;bin_pt_a=@2;type_a=@3;cmplx_a=&4;n_bits_b=@5;bin_pt_b=@6;type_b=@7;mult_latency=@8;multiplier_implementation=&9;replication_ab=&10;opmode=&11;n_bits_c=@12;bin_pt_c=@13;type_c=@14;add_implementation=&15;add_latency=@16;async_add=&17;align_c=&18;replication_c=&19;n_bits_out=@20;bin_pt_out=@21;type_out=@22;quantization=@23;overflow=@24;max_fanout=@25;'), ...
		'MaskValueString', sprintf('0|7|1|on|[18 18]|17|1|3|behavioral HDL|on|Addition|[4 4 4 4]|3|0|behavioral HDL|1|on|off|off|26|24|1|0|0|2'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_maddsub_mask

function bus_maddsub_init(blk)

end % bus_maddsub_init

function bus_dual_port_ram_gen(blk)

	bus_dual_port_ram_mask(blk);
	bus_dual_port_ram_init(blk);
	set_param(blk, ...
		'MaskInitialization', sprintf('bus_dual_port_ram_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''bin_pts'', bin_pts, ...\n    ''init_vector'', init_vector, ...\n    ''max_fanout'', max_fanout, ...\n    ''mem_type'', mem_type, ...\n    ''async_a'', async_a, ...\n    ''async_b'', async_b, ...\n    ''misc'', misc, ...\n    ''bram_latency'', bram_latency, ...\n    ''fan_latency'', fan_latency);'));

end % bus_dual_port_ram_gen

function bus_dual_port_ram_mask(blk)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskType', sprintf('bus_dual_port_ram'), ...
		'MaskDescription', sprintf('RAM for a bus allowing fanout control'), ...
		'MaskPromptString', sprintf('data word bit widths|data word binary points|initial value vector|limit fanout to ?|memory type|a asynchronous |b asynchronous|misc support|bram latency|fanout register latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,popup(Distributed memory|Block RAM),checkbox,checkbox,checkbox,edit,edit'), ...
		'MaskTabNameString', sprintf('basic,basic,basic,basic,basic,basic,basic,basic,latency,latency'), ...
		'MaskCallbackString', sprintf('|||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;bin_pts=@2;init_vector=@3;max_fanout=@4;mem_type=&5;async_a=&6;async_b=&7;misc=&8;bram_latency=@9;fan_latency=@10;'), ...
		'MaskValueString', sprintf('0|17|[[-2:1/(2^3):2-(1/(2^3))]'']|4|Block RAM|off|off|off|2|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_dual_port_ram_mask

function bus_dual_port_ram_init(blk)

end % bus_dual_port_ram_init

