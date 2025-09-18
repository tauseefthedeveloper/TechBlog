package com.techBlog.helper;

import java.util.Map;

import org.apache.tomcat.jakartaee.commons.lang3.ObjectUtils;

public class CloudinaryHelper {
    private static Cloudinary cloudinary;

    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dzhfz9gic",
                "api_key", "732862283762418",
                "api_secret", "z55ymsnYmaJt1FIQ31XiADj62xE"
        ));
    }

    public static String uploadImage(String filePath) throws Exception {
        Map uploadResult = cloudinary.uploader().upload(filePath, ObjectUtils.emptyMap());
        return (String) uploadResult.get("secure_url");
    }
}
