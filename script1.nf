include { INDEX } from './modules/INDEX.nf'

params.reads = "$projectDir/data/ggal/*_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"

log.info """\
    RNASEQ - NF PIPELINE (TRAINING)
    ================================
    transcriptome: ${params.transcriptome_file}
    reads        : ${params.reads}
    outdir       : ${params.outdir}
    """
    .stripIndent(true)

println "reads: $params.reads"

workflow {
    index_ch = INDEX(params.transcriptome_file)
    index_ch.view()
}