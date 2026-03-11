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
    fastqc_ch=FASTQC(read_pairs_ch)
    MULTIQC(quant_ch.mix(fastqc_ch).collect())
}
