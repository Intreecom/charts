{{/*
Expand the name of the chart.
*/}}
{{- define "py-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "py-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "py-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "py-app.labels" -}}
helm.sh/chart: {{ include "py-app.chart" . }}
{{ include "py-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "py-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "py-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "py-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "py-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create env definition for the deployments.

This variable shoule be used in all places where the same envs as in
the main deployment are required. 
*/}}
{{- define "py-app.envs" -}}
{{- with .Values.env }}
env:
    {{- range $key, $val := . }}
    - name: {{ $key }}
      value: {{ $val | quote }}
    {{- end }}
{{- end }}
{{- with .Values.externalSecrets }}
envFrom:
    {{- range $name, $val := . }}
    - secretRef:
        name: {{ $val.targetName }} 
    {{- end }}
{{- end }}
{{ end -}}