nextflow.enable.dsl=2

/*
 * pipeline input parameters
 */
params.reads = "$projectDir/data/yeast/reads/ref1_{1,2}.fq.gz"
params.transcriptome = "$projectDir/data/yeast/transcriptome/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"

log.info """\
         RNASEQ-NF PIPELINE
         ==================
         transcriptome: ${params.transcriptome}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()


read_pairs_ch = Channel
    .fromFilePairs(params.reads, checkIfExists: true)
    .set { read_pairs_ch }
read_pairs_ch.view()
