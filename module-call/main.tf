module "s3backend_mod" {
  source = "git::https://github.com/patgit12/s3backend//s3_module" # make sure not to pass a tag as ref instead of release as ref
  
}