package com.jeemicro.weixin.test;

import java.util.Set;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.jeemicro.weixin.common.mapper.JsonMapper;

import redis.clients.jedis.Jedis;

public class JedisUtilTest {

	private static final String ipAddr = "127.0.0.1";
    private static final int port = 6379;
    private static Jedis jedis= null;

    @BeforeClass
    public static void init()
    {
        jedis = JedisUtil.getInstance().getJedis(ipAddr, port);
    }

    @AfterClass
    public static void close()
    {
        JedisUtil.getInstance().closeJedis(jedis,ipAddr, port);
    }
    
    
    @Test 
    public void testKey() throws InterruptedException
    {
        System.out.println("清空数据："+jedis.flushDB());
        System.out.println("判断某个键是否存在："+jedis.exists("username"));
        System.out.println("新增<'username','zzh'>的键值对："+jedis.set("username", "zzh"));
        System.out.println(jedis.exists("name"));
        System.out.println("新增<'password','password'>的键值对："+jedis.set("password", "password"));
        System.out.print("系统中所有的键如下：");
        Set<String> keys = jedis.keys("*");
        System.out.println(keys);
        System.out.println("删除键password:"+jedis.del("password"));
        System.out.println("判断键password是否存在："+jedis.exists("password"));
        System.out.println("设置键username的过期时间为5s:"+jedis.expire("username", 5));
       // TimeUnit.SECONDS.sleep(2);
        System.out.println("查看键username的剩余生存时间："+jedis.ttl("username"));
        System.out.println("移除键username的生存时间："+jedis.persist("username"));
        System.out.println("查看键username的剩余生存时间："+jedis.ttl("username"));
        System.out.println("查看键username所存储的值的类型："+jedis.type("username"));
    }
    @Test
    public void testHset(){
    	A a = new A();
    	a.setA1("sb1");
    	a.setA2("sb2");
    	jedis.hset("key1", "sb1", JsonMapper.toJsonString(a));
    	jedis.hset("key1", "sb2", JsonMapper.toJsonString(a));
    	
    }
    @Test
    public void testResult(){
    	System.out.println(jedis.hgetAll("key1"));
    }
}
class A{
	public String a1;
	public String a2;
	public String getA1() {
		return a1;
	}
	public void setA1(String a1) {
		this.a1 = a1;
	}
	public String getA2() {
		return a2;
	}
	public void setA2(String a2) {
		this.a2 = a2;
	}
}
