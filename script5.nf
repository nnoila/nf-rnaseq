nextflow.enable.dsl=2

include { FASTQC } from './modules/FASTQC.nf'

/*
* pipeline input parameters
*/
params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"


log.info """\
         RNASEQ-NF PIPELINE
         ===================================
         transcriptome: ${params.transcriptome}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()


Channel
    .fromFilePairs( params.reads, checkIfExists:true )
    .set { read_pairs_ch }

workflow {
    index_ch=INDEX(params.transcriptome)
    quant_ch=QUANT(index_ch,read_pairs_ch)
}
