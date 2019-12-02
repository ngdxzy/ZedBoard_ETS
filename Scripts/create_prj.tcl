set origin_dir "."
if { [info exists ::origin_dir_loc] } {
  set origin_dir $::origin_dir_loc
}

set _xil_proj_name_ Vernier_ETS
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}
variable script_file
set script_file "create_prj.tcl"
if { $::argc > 0 } {
  for {set i 0} { < $::argc} {incr i} {
    set option [string trim [lindex $::argv ]]
    switch -regexp --  {
      --origin_dir   { incr i; set origin_dir [lindex $::argv ] }
      --project_name { incr i; set _xil_proj_name_ [lindex $::argv ] }
      --help         { print_help }
      default {
        if { [regexp {^-} ] } {
          puts ERROR: Unknown option $option specified, please type $script_file -tclargs --help for usage info.n
          return 1
        }
      }
    }
  }
}

set orig_proj_dir "[file normalize "/../Work"]"
create_project Vernier_ETS ../Work
