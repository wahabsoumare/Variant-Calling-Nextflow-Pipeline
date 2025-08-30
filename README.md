# 🧬 pipeline_nextflow

**Auteur** : Abdoul Wahab Soumare  
**Master II** : Bio-Informatique et Biomathématiques – Université Cheikh Anta Diop de Dakar  
**Année** : 2025  
**Cours** : Analyses de données NGS  
**Examen final – Pipeline NGS avec Nextflow**

---

## 🎯 Objectif

Ce pipeline, développé avec [Nextflow](https://www.nextflow.io/), automatise l’analyse de données de séquençage Illumina paired-end de *Plasmodium falciparum*. Il comprend les étapes suivantes :

1. Trimming des reads (suppression des adaptateurs et bases de faible qualité)  
2. Contrôle qualité (FastQC) avant et après trimming  
3. Alignement sur le génome de référence (BWA)  
4. Variant calling (BCFtools)  
5. Annotation des variants (SnpEff)  
6. Visualisation des résultats (Python)

---

## 🗂 Structure du projet

```bash
pipeline_nextflow/
├── main.nf                  # Fichier principal du pipeline
├── nextflow.config          # Paramètres d'exécution
├── modules/                 # Modules Nextflow (étapes du pipeline)
│   ├── trim.nf
│   ├── qc.nf
│   ├── align.nf
│   ├── call_variants.nf
│   ├── annotate.nf
│   └── visualize.nf
├── data/
│   ├── fastq/               # Fichiers FASTQ (R1/R2)
│   └── ref/                 # Référence génomique (FASTA + index BWA)
├── scripts/
│   └── visualize.py         # Script Python de visualisation
├── utils/
│   └── snpEff/              # Outil SnpEff pour l’annotation
└── results/                 # Résultats générés
```

⚙️ Configuration (nextflow.config)

```groovy
nextflow.enable.dsl = 2
process.executor = 'local'

params {
    reads   = 'data/fastq/*_{R1,R2}*.fastq.gz'
    ref     = 'data/ref/ReferencePfGenes.fasta'
    outdir  = 'results'
    adapter = 'CTGTCTCTTATACACATCT'
    snpEff  = "${baseDir}/utils/snpEff/snpEff.jar"
    script  = "${baseDir}/scripts/"
    threads = 4
    cpu     = 4
    memory  = '8 GB'
}
```

▶️ Exécution du pipeline

```bash
nextflow run main.nf
```

Par défaut, le pipeline :

- Cherche les fichiers _R1.fastq.gz et_R2.fastq.gz dans data/fastq/

- Utilise le fichier de référence situé dans data/ref/ReferencePfGenes.fasta

- Génère les résultats dans results/

📦 Étapes du pipeline

| Étape              | Fichier Module              | Description                                     |
|--------------------|-----------------------------|-------------------------------------------------|
| Trimming           | `modules/trim.nf`           | Nettoyage des reads avec l’adaptateur           |
| Contrôle Qualité   | `modules/qc.nf`             | FastQC avant et après trimming                  |
| Alignement         | `modules/align.nf`          | Alignement sur le génome avec BWA               |
| Variant Calling    | `modules/call_variants.nf`  | Détection de SNPs avec BCFtools                 |
| Annotation         | `modules/annotate.nf`       | Annotation des variants avec SnpEff             |
| Visualisation      | `modules/visualize.nf`      | Tableaux et graphiques avec `visualize.py`      |

📊 Résultats générés

- Fichiers FastQC (avant/après)

- BAM alignés, triés et indexés

- Fichiers VCF des variants

- Fichiers annotés avec SnpEff

- Graphiques et tableaux de visualisation (.png, .csv, .html…)

🧪 Données utilisées

- Reads : data/fastq/*.fastq.gz (paired-end)

- Référence : data/ref/ReferencePfGenes.fasta (indexé avec BWA)

- Annotation : via SnpEff dans utils/snpEff/

⚙️ Installation de l’environnement Conda

Ce pipeline repose sur un environnement Conda contenant tous les outils nécessaires pour l’analyse de données NGS.
🔧 Étapes à suivre

1. Installer Conda (si ce n’est pas déjà fait)
    Télécharger et installer Miniconda ou Anaconda depuis : [Anaconda](https://docs.conda.io/en/latest/miniconda.html)

2. Créer l’environnement à partir du fichier fourni :

```bash
conda env create -f environment.yml
```

3. Activer l’environnement :

```bash
conda activate ngs
```

4. (Optionnel) Vérifier les paquets installés :

```bash
conda list
```

✅ L’environnement ngs inclut les outils suivants :

- bwa, samtools, bcftools, fastqc : pour les étapes d’alignement et variant calling

- cutadapt : pour le trimming des reads

- matplotlib, pandas, numpy : pour la visualisation des résultats

- openjdk : pour exécuter SnpEff

- Remarque : Si vous travaillez sur un autre système (Mac, Windows, etc.), il est recommandé de régénérer localement l’environnement avec :

```bash
conda env create -f environment.yml --force
```

📄 Licence

Projet académique — Utilisation libre à des fins pédagogiques.

---
