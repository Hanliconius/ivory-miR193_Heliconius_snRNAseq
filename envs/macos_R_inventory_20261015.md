# Observed local R environment

Reported from installed.packages() on 15 October 2026. This is a partial installed-package inventory, not a dependency lockfile or evidence of successful analysis execution. Package loading and workflow reproduction have not yet been checked in this session.

- R: 4.5.1 (2025-06-13)
- Platform: x86_64-apple-darwin20
- OS: macOS Sonoma 14.7.1
- BLAS: R framework libRblas; LAPACK: R framework libRlapack, version 3.12.1

| Package | Installed version |
| --- | --- |
| Seurat | 5.5.0 |
| SeuratObject | 5.4.0 |
| SeuratDisk | 0.0.0.9021 |
| sctransform | 0.4.3 |
| edgeR | 4.6.3 |
| GenomicRanges | 1.60.0 |
| IRanges | 2.42.0 |
| Rsamtools | 2.24.1 |
| ggplot2 | 4.0.3 |
| ggrepel | 0.9.8 |
| scico | Not found in the active library paths |

The maintained locus plotting script scripts/locus/plot_barcode_reads.R imports scico for its colour palette. Its availability is a plotting-environment requirement; it is not evidence that the Seurat analysis packages are absent. The Pegasus check used a different environment (syntangle_test, R 4.4.3), where these analysis packages were unavailable. All 16 maintained R files passed parsing there.

For a reproducible installation, capture the complete dependency graph and package sources from the actual working environment, including the source revision for development-version SeuratDisk. Do not substitute this table for a complete renv lockfile.
