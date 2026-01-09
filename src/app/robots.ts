import { MetadataRoute } from "next";

// robots.txt 생성
export default function robots(): MetadataRoute.Robots {

  return {
    rules: [
      {
        userAgent: '*', 
        allow: '/',     
        disallow: ['/admin/', '/api/'] 
      }
    ],
    sitemap: `${process.env.NEXT_PUBLIC_BASE_URL || 'http://localhost:3000'}/sitemap.xml` // 사이트맵(sitemap.xml) 파일 경로
  }

}