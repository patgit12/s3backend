module.exports = {
    branches: "main",
    repositoryUrl: "https://github.com/patgit12/s3backend",
    plugins: [
      '@semantic-release/commit-analyzer',
      '@semantic-release/release-notes-generator',
      '@semantic-release/git',
      '@semantic-release/github']
    }      