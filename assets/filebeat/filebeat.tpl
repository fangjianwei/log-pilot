{{range .configList}}
- type: log
  enabled: true
  paths:
      - {{ .HostDir }}/{{ .File }}
  scan_frequency: 10s
  fields_under_root: true
  {{if .Stdout}}
  docker-json: true
  {{end}}
  {{if eq .Format "json"}}
  json.keys_under_root: true
  {{end}}
  fields:
      {{range $key, $value := .Tags}}
      {{ $key }}: {{ $value }}
      {{end}}
      {{range $key, $value := $.container}}
      {{ $key }}: {{ $value }}
      {{end}}
  {{if .Multiline}}
  {{if .Multiline.pattern}}multiline.pattern: '{{.Multiline.pattern}}'{{end}}
  {{if .Multiline.negate}}multiline.negate: {{.Multiline.negate}}{{end}}
  {{if .Multiline.match}}multiline.match: {{.Multiline.match}}{{end}}
  {{if .Multiline.max_lines}}multiline.max_lines: {{.Multiline.max_lines}}{{end}}
  {{if .Multiline.timeout}}multiline.timeout: {{.Multiline.timeout}}{{end}}
  {{if .Multiline.flush_pattern}}multiline.flush_pattern: {{.Multiline.flush_pattern}}{{end}}
  {{end}}
  {{if eq $.output "elasticsearch"}}
  {{if .FormatConfig.pipeline}}pipeline: {{.FormatConfig.pipeline}}{{end}}
  {{end}}
  tail_files: false
  close_inactive: 2h
  close_eof: false
  close_removed: true
  clean_removed: true
  close_renamed: false

{{end}}
