pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 13.2.0" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   GNAT_Version_Address : constant System.Address := GNAT_Version'Address;
   pragma Export (C, GNAT_Version_Address, "__gnat_version_address");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#c8bac64d#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#7320ff5f#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#e25e387f#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#f0509fe6#;
   pragma Export (C, u00004, "systemS");
   u00005 : constant Version_32 := 16#1982dcd0#;
   pragma Export (C, u00005, "system__memoryB");
   u00006 : constant Version_32 := 16#abd4ad36#;
   pragma Export (C, u00006, "system__memoryS");
   u00007 : constant Version_32 := 16#5bea4c0b#;
   pragma Export (C, u00007, "ada__exceptionsB");
   u00008 : constant Version_32 := 16#ac4814eb#;
   pragma Export (C, u00008, "ada__exceptionsS");
   u00009 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00009, "adaS");
   u00010 : constant Version_32 := 16#0740df23#;
   pragma Export (C, u00010, "ada__exceptions__last_chance_handlerB");
   u00011 : constant Version_32 := 16#6dc27684#;
   pragma Export (C, u00011, "ada__exceptions__last_chance_handlerS");
   u00012 : constant Version_32 := 16#fd5f5f4c#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#8dcd0905#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#d4c699bf#;
   pragma Export (C, u00014, "system__secondary_stackB");
   u00015 : constant Version_32 := 16#d8122a51#;
   pragma Export (C, u00015, "system__secondary_stackS");
   u00016 : constant Version_32 := 16#821dff88#;
   pragma Export (C, u00016, "system__parametersB");
   u00017 : constant Version_32 := 16#24c43b40#;
   pragma Export (C, u00017, "system__parametersS");
   u00018 : constant Version_32 := 16#2a95d23d#;
   pragma Export (C, u00018, "system__storage_elementsB");
   u00019 : constant Version_32 := 16#5b04f702#;
   pragma Export (C, u00019, "system__storage_elementsS");
   u00020 : constant Version_32 := 16#0286ce9f#;
   pragma Export (C, u00020, "system__soft_links__initializeB");
   u00021 : constant Version_32 := 16#2ed17187#;
   pragma Export (C, u00021, "system__soft_links__initializeS");
   u00022 : constant Version_32 := 16#8599b27b#;
   pragma Export (C, u00022, "system__stack_checkingB");
   u00023 : constant Version_32 := 16#508536fc#;
   pragma Export (C, u00023, "system__stack_checkingS");
   u00024 : constant Version_32 := 16#c71e6c8a#;
   pragma Export (C, u00024, "system__exception_tableB");
   u00025 : constant Version_32 := 16#7d7be9ff#;
   pragma Export (C, u00025, "system__exception_tableS");
   u00026 : constant Version_32 := 16#c2f520d4#;
   pragma Export (C, u00026, "system__exceptionsS");
   u00027 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00027, "system__exceptions__machineB");
   u00028 : constant Version_32 := 16#8bdfdbe3#;
   pragma Export (C, u00028, "system__exceptions__machineS");
   u00029 : constant Version_32 := 16#7706238d#;
   pragma Export (C, u00029, "system__exceptions_debugB");
   u00030 : constant Version_32 := 16#c05ec7b5#;
   pragma Export (C, u00030, "system__exceptions_debugS");
   u00031 : constant Version_32 := 16#80d3408e#;
   pragma Export (C, u00031, "system__img_intS");
   u00032 : constant Version_32 := 16#f2c63a02#;
   pragma Export (C, u00032, "ada__numericsS");
   u00033 : constant Version_32 := 16#174f5472#;
   pragma Export (C, u00033, "ada__numerics__big_numbersS");
   u00034 : constant Version_32 := 16#0a7ae0bf#;
   pragma Export (C, u00034, "system__unsigned_typesS");
   u00035 : constant Version_32 := 16#ecb207e8#;
   pragma Export (C, u00035, "system__val_intS");
   u00036 : constant Version_32 := 16#faac17dc#;
   pragma Export (C, u00036, "system__val_unsS");
   u00037 : constant Version_32 := 16#96e09402#;
   pragma Export (C, u00037, "system__val_utilB");
   u00038 : constant Version_32 := 16#c3954b6b#;
   pragma Export (C, u00038, "system__val_utilS");
   u00039 : constant Version_32 := 16#b98923bf#;
   pragma Export (C, u00039, "system__case_utilB");
   u00040 : constant Version_32 := 16#3f4348b3#;
   pragma Export (C, u00040, "system__case_utilS");
   u00041 : constant Version_32 := 16#3f3fad5d#;
   pragma Export (C, u00041, "system__wid_unsS");
   u00042 : constant Version_32 := 16#5c7d9c20#;
   pragma Export (C, u00042, "system__tracebackB");
   u00043 : constant Version_32 := 16#76ca6b5b#;
   pragma Export (C, u00043, "system__tracebackS");
   u00044 : constant Version_32 := 16#5f6b6486#;
   pragma Export (C, u00044, "system__traceback_entriesB");
   u00045 : constant Version_32 := 16#384c206a#;
   pragma Export (C, u00045, "system__traceback_entriesS");
   u00046 : constant Version_32 := 16#6ba3967c#;
   pragma Export (C, u00046, "system__traceback__symbolicB");
   u00047 : constant Version_32 := 16#d9e66ad1#;
   pragma Export (C, u00047, "system__traceback__symbolicS");
   u00048 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00048, "ada__containersS");
   u00049 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00049, "ada__exceptions__tracebackB");
   u00050 : constant Version_32 := 16#eb07882c#;
   pragma Export (C, u00050, "ada__exceptions__tracebackS");
   u00051 : constant Version_32 := 16#6ef2c461#;
   pragma Export (C, u00051, "system__bounded_stringsB");
   u00052 : constant Version_32 := 16#87adbeff#;
   pragma Export (C, u00052, "system__bounded_stringsS");
   u00053 : constant Version_32 := 16#aec2a9b8#;
   pragma Export (C, u00053, "system__crtlS");
   u00054 : constant Version_32 := 16#9f199b4a#;
   pragma Export (C, u00054, "system__dwarf_linesB");
   u00055 : constant Version_32 := 16#17f6aaf0#;
   pragma Export (C, u00055, "system__dwarf_linesS");
   u00056 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00056, "ada__charactersS");
   u00057 : constant Version_32 := 16#f70a517e#;
   pragma Export (C, u00057, "ada__characters__handlingB");
   u00058 : constant Version_32 := 16#ea6baced#;
   pragma Export (C, u00058, "ada__characters__handlingS");
   u00059 : constant Version_32 := 16#cde9ea2d#;
   pragma Export (C, u00059, "ada__characters__latin_1S");
   u00060 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00060, "ada__stringsS");
   u00061 : constant Version_32 := 16#16f45e54#;
   pragma Export (C, u00061, "ada__strings__mapsB");
   u00062 : constant Version_32 := 16#9df1863a#;
   pragma Export (C, u00062, "ada__strings__mapsS");
   u00063 : constant Version_32 := 16#96b40646#;
   pragma Export (C, u00063, "system__bit_opsB");
   u00064 : constant Version_32 := 16#3da333da#;
   pragma Export (C, u00064, "system__bit_opsS");
   u00065 : constant Version_32 := 16#4642cba6#;
   pragma Export (C, u00065, "ada__strings__maps__constantsS");
   u00066 : constant Version_32 := 16#15f799c2#;
   pragma Export (C, u00066, "interfacesS");
   u00067 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00067, "system__address_imageB");
   u00068 : constant Version_32 := 16#51bc02dc#;
   pragma Export (C, u00068, "system__address_imageS");
   u00069 : constant Version_32 := 16#7fca0124#;
   pragma Export (C, u00069, "system__img_unsS");
   u00070 : constant Version_32 := 16#20ec7aa3#;
   pragma Export (C, u00070, "system__ioB");
   u00071 : constant Version_32 := 16#6e1268a9#;
   pragma Export (C, u00071, "system__ioS");
   u00072 : constant Version_32 := 16#b25b689d#;
   pragma Export (C, u00072, "system__mmapB");
   u00073 : constant Version_32 := 16#c87b9b1c#;
   pragma Export (C, u00073, "system__mmapS");
   u00074 : constant Version_32 := 16#367911c4#;
   pragma Export (C, u00074, "ada__io_exceptionsS");
   u00075 : constant Version_32 := 16#2e05e25c#;
   pragma Export (C, u00075, "system__mmap__os_interfaceB");
   u00076 : constant Version_32 := 16#52ab6463#;
   pragma Export (C, u00076, "system__mmap__os_interfaceS");
   u00077 : constant Version_32 := 16#1d7382c4#;
   pragma Export (C, u00077, "system__os_libB");
   u00078 : constant Version_32 := 16#0a3c4fb9#;
   pragma Export (C, u00078, "system__os_libS");
   u00079 : constant Version_32 := 16#6e5d049a#;
   pragma Export (C, u00079, "system__atomic_operations__test_and_setB");
   u00080 : constant Version_32 := 16#57acee8e#;
   pragma Export (C, u00080, "system__atomic_operations__test_and_setS");
   u00081 : constant Version_32 := 16#3733e5c3#;
   pragma Export (C, u00081, "system__atomic_operationsS");
   u00082 : constant Version_32 := 16#29cc6115#;
   pragma Export (C, u00082, "system__atomic_primitivesB");
   u00083 : constant Version_32 := 16#b719d7c7#;
   pragma Export (C, u00083, "system__atomic_primitivesS");
   u00084 : constant Version_32 := 16#545fe66d#;
   pragma Export (C, u00084, "interfaces__cB");
   u00085 : constant Version_32 := 16#9d395173#;
   pragma Export (C, u00085, "interfaces__cS");
   u00086 : constant Version_32 := 16#256dbbe5#;
   pragma Export (C, u00086, "system__stringsB");
   u00087 : constant Version_32 := 16#6bd29ffe#;
   pragma Export (C, u00087, "system__stringsS");
   u00088 : constant Version_32 := 16#2fdbc40e#;
   pragma Export (C, u00088, "system__object_readerB");
   u00089 : constant Version_32 := 16#e7c98bed#;
   pragma Export (C, u00089, "system__object_readerS");
   u00090 : constant Version_32 := 16#65ddb07c#;
   pragma Export (C, u00090, "system__val_lliS");
   u00091 : constant Version_32 := 16#d863c536#;
   pragma Export (C, u00091, "system__val_lluS");
   u00092 : constant Version_32 := 16#bad10b33#;
   pragma Export (C, u00092, "system__exception_tracesB");
   u00093 : constant Version_32 := 16#1cc8f680#;
   pragma Export (C, u00093, "system__exception_tracesS");
   u00094 : constant Version_32 := 16#b9a6a00a#;
   pragma Export (C, u00094, "system__win32S");
   u00095 : constant Version_32 := 16#fd158a37#;
   pragma Export (C, u00095, "system__wch_conB");
   u00096 : constant Version_32 := 16#2953bc85#;
   pragma Export (C, u00096, "system__wch_conS");
   u00097 : constant Version_32 := 16#5c289972#;
   pragma Export (C, u00097, "system__wch_stwB");
   u00098 : constant Version_32 := 16#04429084#;
   pragma Export (C, u00098, "system__wch_stwS");
   u00099 : constant Version_32 := 16#f8305de6#;
   pragma Export (C, u00099, "system__wch_cnvB");
   u00100 : constant Version_32 := 16#2f9376f5#;
   pragma Export (C, u00100, "system__wch_cnvS");
   u00101 : constant Version_32 := 16#e538de43#;
   pragma Export (C, u00101, "system__wch_jisB");
   u00102 : constant Version_32 := 16#9a2414df#;
   pragma Export (C, u00102, "system__wch_jisS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.atomic_operations%s
   --  system.io%s
   --  system.io%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.traceback%s
   --  system.traceback%b
   --  ada.characters.handling%s
   --  system.atomic_operations.test_and_set%s
   --  system.case_util%s
   --  system.os_lib%s
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.val_uns%s
   --  system.val_int%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.bit_ops%s
   --  system.bit_ops%b
   --  system.bounded_strings%s
   --  system.bounded_strings%b
   --  system.case_util%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  ada.numerics.big_numbers%s
   --  ada.strings%s
   --  ada.strings.maps%s
   --  ada.strings.maps%b
   --  ada.strings.maps.constants%s
   --  interfaces.c%s
   --  interfaces.c%b
   --  system.atomic_primitives%s
   --  system.atomic_primitives%b
   --  system.exceptions%s
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.win32%s
   --  ada.characters.handling%b
   --  system.atomic_operations.test_and_set%b
   --  system.exception_traces%s
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.mmap%s
   --  system.mmap.os_interface%s
   --  system.mmap.os_interface%b
   --  system.mmap%b
   --  system.object_reader%s
   --  system.object_reader%b
   --  system.dwarf_lines%s
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  system.wid_uns%s
   --  system.img_int%s
   --  ada.exceptions%b
   --  system.img_uns%s
   --  system.dwarf_lines%b
   --  main%b
   --  END ELABORATION ORDER

end ada_main;
