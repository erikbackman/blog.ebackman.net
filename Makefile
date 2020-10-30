build-production:
	HUGO_ENV=production hugo

deploy: build-production
	aws s3 sync public/ $(S3_BUCKET) --size-only --delete

aws-cloudfront-invalidate-all:
	aws cloudfront create-invalidation --distribution-id $(CF_BLOG_DISTRIBUTION_ID) --paths "/*"
