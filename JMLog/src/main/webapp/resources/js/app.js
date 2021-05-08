// AWS S3 Bucket 자격 증명에 대한 내용

var albumBucketName = 'jmlog-profileimg';
var bucketRegion = 'ap-northeast-2';
var IdentityPoolId = 'ap-northeast-2:9f7b66a7-a639-43ef-bbe8-81b53a271e88';

AWS.config.update({
  region: bucketRegion,
  credentials: new AWS.CognitoIdentityCredentials({
    IdentityPoolId: IdentityPoolId
  })
});

var s3 = new AWS.S3({
  apiVersion: '2006-03-01',
  params: {Bucket: albumBucketName}
});