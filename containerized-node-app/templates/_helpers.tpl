{{/*
Expand the name of the chart.
*/}}
{{- define "containerized-node-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "containerized-node-app.fullname" -}}
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
{{- define "containerized-node-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "containerized-node-app.labels" -}}
helm.sh/chart: {{ include "containerized-node-app.chart" . }}
{{ include "containerized-node-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "containerized-node-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "containerized-node-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: "containerized-node-app"
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: api
app.kubernetes.io/part-of: applications
app.kubernetes.io/created-by: helm
kubernetes.io/description: An app that prints hello world at it's home endpoint
{{- end }}

{{/*
Some Annotations
*/}}
{{- define "containerized-node-app.annotations" -}}
fullName: {{ include "containerized-node-app.fullName" . }}
lastCreated: {{ now | date "2006-01-02"}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "containerized-node-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "containerized-node-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
