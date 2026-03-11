/*
 * Run Salmon to perform the quantification of expression using
 * the index and the matched read files
 */
process QUANT {
    tag "Salmon on $sample_id"
    publishDir params.outdir, mode: 'copy'

    input:
    path index
    tuple val(pair_id), path(reads)

    output:
    path(pair_id)

    script:
    """
    salmon quant --threads $task.cpus --libType=U -i $index -1 ${reads[0]} -2 ${reads[1]} -o $pair_id
    """
}

workflow{
    QUANT
}