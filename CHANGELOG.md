## 8.0.0 (2025-03-07)

### ⚠ BREAKING CHANGES

* **AZ-1088:** AzureRM Provider v4+ and OpenTofu 1.8+

### Features

* **AZ-1088:** module v8 structure and updates 57eb6fb

### Miscellaneous Chores

* **deps:** update dependency claranet/diagnostic-settings/azurerm to v7 bba47a0
* **deps:** update dependency opentofu to v1.8.3 09aa761
* **deps:** update dependency opentofu to v1.8.4 9bb9260
* **deps:** update dependency opentofu to v1.8.6 b0b181a
* **deps:** update dependency opentofu to v1.8.8 83bf0da
* **deps:** update dependency opentofu to v1.9.0 8bdadab
* **deps:** update dependency pre-commit to v4 244c81d
* **deps:** update dependency pre-commit to v4.0.1 b8f8c11
* **deps:** update dependency pre-commit to v4.1.0 455d213
* **deps:** update dependency tflint to v0.54.0 9fe247c
* **deps:** update dependency tflint to v0.55.0 3d626c9
* **deps:** update dependency tflint to v0.55.1 16d0b56
* **deps:** update dependency trivy to v0.56.1 1622239
* **deps:** update dependency trivy to v0.56.2 aec5501
* **deps:** update dependency trivy to v0.57.1 02e1923
* **deps:** update dependency trivy to v0.58.1 ad4de78
* **deps:** update dependency trivy to v0.58.2 32e7bb7
* **deps:** update dependency trivy to v0.59.0 0a40943
* **deps:** update dependency trivy to v0.59.1 0d71b74
* **deps:** update dependency trivy to v0.60.0 34e42eb
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 9d7adaa
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 b2e3161
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 07653f2
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 a7124da
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 49a7f52
* **deps:** update tools a0d4a8e
* **deps:** update tools b20a55a
* prepare for new examples structure 4ce3c41
* update examples structure 2d701f8
* update Github templates 0f6cc96
* update tflint config for v0.55.0 6a904c5

## 7.2.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 7d44c46

### Documentation

* update README badge to use OpenTofu registry 877b283
* update README with `terraform-docs` v0.19.0 cd894f5

### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] c7afff6
* **AZ-1391:** update semantic-release config [skip ci] 18a2099

### Miscellaneous Chores

* **deps:** add renovate.json 5275d73
* **deps:** enable automerge on renovate d370d5c
* **deps:** update dependency opentofu to v1.7.0 42a49f1
* **deps:** update dependency opentofu to v1.7.1 8b2d0e6
* **deps:** update dependency opentofu to v1.7.2 02214c6
* **deps:** update dependency opentofu to v1.7.3 0fdd421
* **deps:** update dependency opentofu to v1.8.1 17e370a
* **deps:** update dependency opentofu to v1.8.2 bd877e6
* **deps:** update dependency pre-commit to v3.7.1 8f6e884
* **deps:** update dependency pre-commit to v3.8.0 d320dd2
* **deps:** update dependency terraform-docs to v0.18.0 3fa3261
* **deps:** update dependency tflint to v0.51.0 1e4ba78
* **deps:** update dependency tflint to v0.51.1 ae3ffdb
* **deps:** update dependency tflint to v0.51.2 b450ed2
* **deps:** update dependency tflint to v0.52.0 eacba38
* **deps:** update dependency trivy to v0.50.2 8a1d3ce
* **deps:** update dependency trivy to v0.50.4 1a5e808
* **deps:** update dependency trivy to v0.51.0 bbe9f46
* **deps:** update dependency trivy to v0.51.1 3fc6829
* **deps:** update dependency trivy to v0.51.2 aae6c40
* **deps:** update dependency trivy to v0.51.4 5a20d6e
* **deps:** update dependency trivy to v0.52.0 1cb2f4b
* **deps:** update dependency trivy to v0.52.1 f6bba93
* **deps:** update dependency trivy to v0.52.2 de4743b
* **deps:** update dependency trivy to v0.53.0 a593011
* **deps:** update dependency trivy to v0.55.0 dc228ba
* **deps:** update dependency trivy to v0.55.1 1159223
* **deps:** update dependency trivy to v0.55.2 44327f3
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 c801b9c
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 86a951c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 ab8b66d
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 a3acb4b
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 72a868f
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 ade58f0
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 35c6690
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 ae09872
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 83eaeb2
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 4ac9d80
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 1eb539a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 df2a8c9
* **deps:** update renovate.json 7c3b046
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 6.5.0 06c4a1a
* **deps:** update tools 4ca30bf
* **deps:** update tools 03f0445
* **deps:** update tools a396ef3
* **pre-commit:** update commitlint hook eea9538
* **release:** remove legacy `VERSION` file 87c2dc9

# v7.1.0 - 2022-11-28

Changed
  * AZ-908: Use the new data source for CAF naming (instead of resource)

# v7.0.0 - 2022-09-30

Breaking
  * AZ-840: Update to Terraform `v1.3`

Added
  * AZ-682: Initialize Synapse module
