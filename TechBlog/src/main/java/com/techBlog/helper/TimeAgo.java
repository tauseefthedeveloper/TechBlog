package com.techBlog.helper;
import java.time.Duration;
import java.time.LocalDateTime;

public class TimeAgo {
	public static String toTimeAgo(LocalDateTime past) {
	    LocalDateTime now = LocalDateTime.now();
	    Duration duration = Duration.between(past, now);

	    long seconds = duration.getSeconds();

	    if (seconds < 60) {
	        return seconds + " sec ago";
	    } else if (seconds < 3600) {
	        return (seconds / 60) + " mins ago";
	    } else if (seconds < 86400) {
	        return (seconds / 3600) + " hours ago";
	    } else if (seconds < 2592000) {
	        return (seconds / 86400) + " days ago";
	    } else if (seconds < 31536000) {
	        return (seconds / 2592000) + " months ago";
	    } else {
	        return (seconds / 31536000) + " years ago";
	    }
	}

}
