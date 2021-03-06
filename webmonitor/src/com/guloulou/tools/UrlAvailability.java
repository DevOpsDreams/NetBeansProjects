/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guloulou.tools;

import java.net.HttpURLConnection;
import java.net.URL;

/**
 *
 * @author kang.cunhua
 */
public class UrlAvailability {

    private static URL urlStr;
    private static HttpURLConnection connection;
    private static int state = -1;
    private static boolean succ;

    /**
     * 功能描述 : 检测当前URL是否可连接或是否有效,
     * 最多连接网络 5 次, 如果 5 次都不成功说明该地址不存在或视为无效地址.
     * @param url 指定URL网络地址 
     * @return String
     */
    public UrlAvailability(){
    }
    public static UrlAvailability getInstance(){
        return new UrlAvailability();
    }
    public synchronized boolean isConnect(String url) {
        int counts = 0;
        succ = false;
        if (url == null || url.length() <= 0) {
            return succ;
        }
        while (counts < 5) {
            try {
                urlStr = new URL(url);
                connection = (HttpURLConnection) urlStr.openConnection();
                state = connection.getResponseCode();
                if (state == 200) {
                    // succ = connection.getURL().toString();
                    succ = true;
                }
                break;
            } catch (Exception ex) {
                counts++;
                continue;
            }
        }
        return succ;
    }
    public static void main(String [] args){
        System.out.println((UrlAvailability.getInstance()).isConnect("http://www.guloulou.com"));
        System.out.println((UrlAvailability.getInstance()).isConnect("http://10.5.5.94:7001/check.jsp"));
    }
}


