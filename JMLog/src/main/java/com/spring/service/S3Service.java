package com.spring.service;

import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Service
public class S3Service {
	
	// 설정 파일의 S3 관련 프로퍼티 값 설정
	private static AmazonS3 s3Client;
	final private String accessKey = "AKIARNTOYYWJX2B2CBUX";
	final private String secretKey = "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";
	private String bucket = "jmlog-profileimg";
	private Regions clientRegion = Regions.AP_NORTHEAST_2;
	
	private S3Service() {
        createS3Client();
    }

    //singleton pattern
    static private S3Service instance = null;
    
    public static S3Service getInstance() {
        if (instance == null) {
            return new S3Service();
        } else {
            return instance;
        }
    }
	
	// AmazonS3Client 객체 생성
	@PostConstruct	//S3Servoce 사용되기 이전에 AmazonS3Client 객체 생성
	public void createS3Client() {
		AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
		this.s3Client = AmazonS3ClientBuilder.standard()
				.withCredentials(new AWSStaticCredentialsProvider(credentials))
				.withRegion(clientRegion)
				.build();
	}
	
	// 파일 명과 경로를 직접 지정하여 업로드
	public String upload(MultipartFile file) throws IOException{
		return upload(file, "", file.getOriginalFilename());
	}
	
	// 파일 명, 경로 직접 지정 않는 업로드
	public String upload(MultipartFile file, String dirName, String fileName) throws IOException {
        String filePath = dirName+"/"+fileName;

        // s3Client.putObject를 이용해 aws s3에 업로드
        s3Client.putObject(new PutObjectRequest(bucket, filePath, file.getInputStream(), null)
                .withCannedAcl(CannedAccessControlList.PublicRead));
        return s3Client.getUrl(bucket, filePath).toString();
    }
	
	public void delete(String filePath){
		// 파일이 존재하는지 확인
        boolean isExistObject = s3Client.doesObjectExist(bucket, filePath);
        if (isExistObject == true) {	// 파일 존재 시 삭제 진행
        	// deleteObject를 이용해 파일 삭제
            s3Client.deleteObject(bucket, filePath);
        }
    }
}
