package com.techBlog.helper;

import java.util.HashMap;
import java.util.Map;

import com.cloudinary.utils.ObjectUtils;

import com.cloudinary.Cloudinary;

public class CloudinaryHelper {
    private static Cloudinary cloudinary;

    static {
    	Map<String, String> config = new HashMap<>();
    	config.put("cloud_name", "dzhfz9gic");
    	config.put("api_key", "732862283762418");
    	config.put("api_secret", "z55ymsnYmaJt1FIQ31XiADj62xE");
        cloudinary = new Cloudinary(config);
    }

    public static String uploadImage(String filePath) throws Exception {
        Map uploadResult = cloudinary.uploader().upload(filePath, ObjectUtils.emptyMap());
        return (String) uploadResult.get("secure_url");
    }
}
