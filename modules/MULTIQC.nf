/*
 * Create a report using multiQC for the quantification
 * and fastqc processes
 */
process MULTIQC {
    publishDir "${params.outdir}/multiqc", mode:'copy'

    input:
    path('*')

    output:
    path('multiqc_report.html')

    script:
    """
    multiqc .
    """
}

workflow {
    MULTIQC
}