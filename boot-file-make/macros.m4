m4_define(`m4_forloop', `m4_ifelse(`$3', `0', `', `m4_pushdef(`$1', `$2')_m4_forloop($@)m4_popdef(`$1')')')
m4_define(`_m4_forloop',
          `$4`'m4_ifelse($1, `$3', `', `m4_define(`$1', m4_incr($1))$0($@)')')
m4_define(`__overlay', `m4_define(`__overlay_helper', m4_format(`$%d',$1))__overlay_helper('m4_defn(`__OVERLAYS')`)')
