/*
 * Example showing pipeline modularizaion
 * Author: Paolo Di Tommaso
 */
nextflow.enable.dsl=2

include { INDEX } from './modules/INDEX.nf'
include { QUANT } from './modules/QUANT.nf'
include { FASTQC } from './modules/FASTQC.nf'
include { MULTIQC } from './modules/MULTIQC.nf'

/*
 * pipeline input parameters
 */
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


include { RNASEQFLOW } from './modules/rnaseq-flow.nf'

workflow {
    read_pairs_ch = Channel .fromFilePairs( params.reads, checkIfExists:true )
    RNASEQFLOW( params.transcriptome_file, read_pairs_ch )
}
