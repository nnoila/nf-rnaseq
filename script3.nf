nextflow.enable.dsl=2

/*
 * pipeline input parameters
 */
params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcriptome = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"

log.info """\
         RNASEQ-NF PIPELINE
         ==================
         transcriptome: ${params.transcriptome}
         reads        : ${params.reads}
         outdir       : ${params.outdir}4         """
         .stripIndent()


read_pairs_ch = Channel
    .fromFilePairs(params.reads, checkIfExists: true)