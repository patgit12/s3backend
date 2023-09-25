module "s3backend_mod" {
  source = "git@github.com:patgit12/s3backend.git//s3_module?ref=v1.2.1" # make sure not to pass a tag as ref instead of release as ref
  
}