nextflow.enable.dsl=2

include { INDEX } from './modules/INDEX.nf'
include { QUANT } from './modules/QUANT.nf'

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

println("outdir is ${params.outdir}")

workflow {
    read_pairs_ch = Channel
                    .fromFilePairs( params.reads, checkIfExists:true )
                    .view()
    index_ch=INDEX(params.transcriptome_file)
    quant_ch=QUANT(index_ch, read_pairs_ch)
}
