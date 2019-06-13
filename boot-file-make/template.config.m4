m4_divert(-1)

m4_define(__LSB_INIT_INFO, `# Provides: template
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.')
m4_define(__WORKINGDIR, /opt/template)
m4_define(__CMD, template)
m4_define(__CMDUSER, _template)

m4_changecom(`@@##')
m4_changequote(`%[', `]%')

m4_divert(0)m4_dnl
