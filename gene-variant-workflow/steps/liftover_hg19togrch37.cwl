class: CommandLineTool
cwlVersion: v1.0
id: liftover_vcf
baseCommand:
  - bash
  - /usr/working/liftover-vcf.sh
inputs:
  - id: hg19vcf
    type: File
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: grch37vcf
    type: File
    outputBinding:
      glob: '*_grch37.vcf'
  - id: rejected
    type: File?
    outputBinding:
      glob: '*rej.vcf'
label: liftover-vcf
requirements:
  - class: ResourceRequirement
    ramMin: 8000
    coresMin: 0
  - class: DockerRequirement
    dockerPull: nfosi/liftover-hg19-to-grch37
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.hg19vcf)
        writable: true
  - class: InlineJavascriptRequirement
