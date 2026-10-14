# Maintained-code validation

Run from the repository root in the intended R analysis environment:

```bash
Rscript tools/validate_maintained_code.R . > maintained-code-validation.log 2>&1
```

The checker parses R files in scripts/ and tools/ without sourcing them, discovers literal library/namespace dependencies, and reports package versions plus sessionInfo(). It also checks sctransform. Exit 0 means parsing and discovered dependency checks passed; 1 means a parse failure; 2 means missing dependencies. Dependencies conditional on optional inputs (such as SeuratDisk for h5seurat) are reported too. Dynamic package names and external executables require separate workflow checks.

Archive snapshots are provenance, not maintained executable workflows. The previous broad audit failed while parsing an archived exploratory file; that does not establish a syntax defect in maintained scripts. Maintained parsing and an appropriate installed environment still require an actual successful run. No end-to-end scientific reproduction is claimed.

Keep sequencing data, saved analysis objects, and intermediates outside Git. Publish accession IDs, reference versions/checksums, required metadata, workflow commands, and actual environment exports. Do not infer a lockfile from manuscript version labels. See REPRODUCIBILITY.md and FILE_REQUESTS.md for unresolved scientific inputs.
