/*
 * Run fastQC to check quality of reads files
 */
process FASTQC {
    tag "FASTQC on $pair_id"
    cpus 1

    input:
    tuple val(pair_id), path(reads)

    output:
    path("fastqc_${pair_id}_logs")

    script:
    """
    mkdir fastqc_${pair_id}_logs
    fastqc -o fastqc_${pair_id}_logs -f fastq -q ${reads} -t ${task.cpus}
    """
}

workflow {
    FASTQC
}