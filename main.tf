terraform {
    required_providers {
        github = {
            source = "integrations/github"
            version = "~> 5.0"
        }
    }
}

provider "github" {
    token = var.token
}

resource "github_repository" "example" {
  name        = "ARQ-TICS"
  description = "Repo para ArqueTics"
  visibility = "public"
}

resource "github_repository_file" "readme" {
  repository = github_repository.example.name
  file  = "README.md"
  content    = "# Repo para ArqueTics"
  depends_on = [github_repository.example]
}

resource "github_repository_file" "readme_commit" {
  repository = github_repository.example.name
  file  = "README.md"
  branch     = "main"
  commit_message = "Agregado archivo README.md"
  overwrite_on_create = true
  content    = github_repository_file.readme.content
  depends_on = [github_repository_file.readme]
}

resource "github_branch" "development" {
  repository = "ARQ-TICS"
  branch     = "dev"
  depends_on = [github_repository_file.readme_commit]
}