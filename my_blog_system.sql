/*
 Navicat Premium Dump SQL

 Source Server         : Spring Boot
 Source Server Type    : MySQL
 Source Server Version : 90400 (9.4.0)
 Source Host           : localhost:3306
 Source Schema         : my_blog_system

 Target Server Type    : MySQL
 Target Server Version : 90400 (9.4.0)
 File Encoding         : 65001

 Date: 07/01/2026 21:45:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文章标题',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者用户名',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '文章具体内容',
  `created` datetime NOT NULL COMMENT '发表时间',
  `modified` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `categories` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '默认分类' COMMENT '文章分类',
  `tags` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章标签',
  `allow_comment` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否允许评论',
  `thumbnail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章缩略图',
  `user_id` int NULL DEFAULT NULL COMMENT '作者ID',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布地点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES (1, '2018新版Java学习路线图', '东方不败', '&ensp;&ensp;&ensp;&ensp;播妞深知广大爱好Java的人学习是多么困难，没视频没资源，上网花钱还老担心被骗。因此专门整理了新版的学习路线图，不管你是不懂电脑的小白，还是已经步入开发的大牛，这套路线图绝对不容错过！12年传智播客黑马程序员分享免费视频教程长达10余万小时，累计下载量3000余万次，受益人数达千万。2018年我们不忘初心，继续前行。 路线图的宗旨就是分享，专业，便利，让喜爱Java的人，都能平等的学习。从今天起不要再找借口，不要再说想学Java却没有资源，赶快行动起来，Java等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版Java学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/roadmap/1.jpg)\r\n\r\n**二、2018新版Java学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/roadmap/2.jpg)\r\n\r\n![alt](/article_img/roadmap/3.jpg)\r\n\r\n**三、2018新版Java学习路线图---升级后新增知识点一览**\r\n![alt](/article_img/roadmap/4.jpg)\r\n\r\n\r\n\r\n', '2018-10-10 00:00:00', NULL, '默认分类', '#2018 #Java #学习路线图', 1, '/api/images/11.png', 3, NULL);
INSERT INTO `t_article` VALUES (2, '2018新版Python学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;12年历经风雨，传智播客黑马程序员已免费分享视频教程长达10万余小时，累计下载量超2000万次，受益人数达千万。2018年我们不忘初心，继续前行。学习路线图的宗旨就是分享，专业，便利，让喜爱Python的人，都能平等的学习。据悉，Python已经入驻小学生教材，未来不学Python不仅知识会脱节，可能与小朋友都没有了共同话题~~所以，从今天起不要再找借口，不要再说想学Python却没有资源，赶快行动起来，Python等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版Python学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/phmap/1.jpg)\r\n\r\n![alt](/article_img/phmap/2.jpg)\r\n\r\n**二、2018新版Python学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/phmap/3.jpg)\r\n\r\n![alt](/article_img/phmap/4.jpg)\r\n\r\n**三、2018新版Python学习路线图---升级版Python成长路径**\r\n![alt](/article_img/phmap/5.jpg)\r\n\r\n![alt](/article_img/phmap/6.jpg)', '2018-10-23 00:00:00', '2025-12-02 00:00:00', '默认分类', '#2018 #Python #学习线路图', 1, '/api/images/23f79d77-ee9d-4899-a2f3-da6415b3f098.jpg', 3, NULL);
INSERT INTO `t_article` VALUES (3, '2018新版前端与移动开发学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;传智播客黑马程序员作为一个IT学习平台，历经12年的成长，免费分享视频教程长达10万余小时，累计下载量超3000万次，受益人数达千万。2018年我们不忘初心，继续前行！路线图的宗旨就是分享，专业，便利，让更多想要学习IT的人都能系统的学习！从今天起不要再找借口，不要再说想学却没有资源，赶快行动起来，前端与移动开发等你来探索，高薪距你只差一步！注：新版前端与移动开发学习大纲于2018年2月26日完成升级，本学习路线图依据最新升级后的规划制作！\r\n\r\n**一、2018新版前端与移动开发学习路线图---每阶段可掌握的能力及可解决的问题**\r\n![alt](/article_img/frmap/1.jpg)\r\n\r\n![alt](/article_img/frmap/2.jpg)\r\n\r\n**二、2018新版前端与移动开发学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/frmap/3.jpg)\r\n\r\n![alt](/article_img/frmap/4.jpg)\r\n\r\n**三、2018新版前端与移动开发学习路线图--升级后新增知识点设计理念**\r\n![alt](/article_img/frmap/5.jpg)', '2018-11-13 00:00:00', NULL, '默认分类', '#2018 #前端与移动 #学习线路图', 1, '/api/images/9.png', 3, NULL);
INSERT INTO `t_article` VALUES (4, '2018新版PHP学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;传智播客黑马程序员作为一个IT学习平台，历经12年的成长，免费分享视频教程长达10万余小时，累计下载量超3000万次，受益人数达千万。2018年我们不忘初心，继续前行！路线图的宗旨就是分享，专业，便利，让更多喜爱PHP的人都能系统的学习！从今天起不要再找借口，不要再说想学PHP却没有资源，赶快行动起来，PHP等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版PHP学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/phpmap/1.jpg)\r\n\r\n![alt](/article_img/phpmap/2.jpg)\r\n\r\n**二、2018新版PHP学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/phpmap/3.jpg)\r\n\r\n![alt](/article_img/phpmap/4.jpg)\r\n\r\n**三、2018新版PHP学习路线图---升级后新增知识点设计理念**\r\n![alt](/article_img/phpmap/5.jpg)\r\n', '2018-11-16 00:00:00', NULL, '默认分类', '#2018 #PHP #学习线路图', 1, '/api/images/8.png', 3, NULL);
INSERT INTO `t_article` VALUES (5, '2018版Go语言+区块链学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;12年传智播客黑马程序员分享免费视频教程长达10万余小时，累计下载量超3000万次，受益人数达千万。2018年我们不忘初心，继续前行。 路线图的宗旨就是分享，专业，便利，让喜爱Go语言+区块链的人，都能平等的学习。从今天起不要再找借口，不要再说想学Go语言+区块链却没有资源，赶快行动起来，Go语言+区块链等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版Go语言+区块链学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/gomap/1.jpg)\r\n\r\n![alt](/article_img/gomap/2.jpg)\r\n\r\n**二、2018新版Go语言+区块链学习路线图---每阶段可掌握的核心能力**\r\n![alt](/article_img/gomap/3.jpg)\r\n\r\n**三、2018新版Go语言+区块链学习路线图---每阶段的设计理念**\r\n![alt](/article_img/gomap/4.jpg)\r\n\r\n**四、2018新版Go语言+区块链学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/gomap/5.jpg)\r\n\r\n![alt](/article_img/gomap/6.jpg)', '2018-11-27 00:00:00', NULL, '默认分类', '#2018 #Go语言 #区块链,学习线路图', 1, '/api/images/7.png', 3, NULL);
INSERT INTO `t_article` VALUES (6, 'JDK 8——Lambda表达式介绍', 'tom', '  Lambda表达式是JDK 8中一个重要的新特性，它使用一个清晰简洁的表达式来表达一个接口，同时Lambda表达式也简化了对集合以及数组数据的遍历、过滤和提取等操作。下面，本篇文章就对Lambda表达式进行简要介绍，并进行演示说明。\r\n\r\n**1. Lambda表达式入门**  \r\n\r\n  匿名内部类存在的一个问题是，如果匿名内部类的实现非常简单，例如只包含一个抽象方法的接口，那么匿名内部类的语法仍然显得比较冗余。为此，JDK 8中新增了一个特性Lambda表达式，这种表达式只针对有一个抽象方法的接口实现，以简洁的表达式形式实现接口功能来作为方法参数。  \r\n  一个Lambda表达式由三个部分组成，分别为参数列表、“->”和表达式主体，其语法格式如下：\r\n```js\r\n ([数据类型 参数名,数据类型 参数名,...]) -> {表达式主体}\r\n```  \r\n  从上述语法格式上看，Lambda表达式的书写非常简单，下面针对Lambda表达式的组成部分进行简单介绍，具体如下：  \r\n  （1）([数据类型 参数名,数据类型 参数名,...])：用来向表达式主体传递接口方法需要的参数，多个参数名中间必须用英文逗号“,”进行分隔；在编写Lambda表达式时，可以省略参数的数据类型，后面的表达式主体会自动进行校对和匹配；同时，如果只有一个参数，则可以省略括号“()”。  \r\n  （2）->：表示Lambda表达式箭牌，用来指定参数数据指向，不能省略，且必须用英文横线和大于号书写。  \r\n  （3）{表达式主体}：由单个表达式或语句块组成的主体，本质就是接口中抽象方法的具体实现，如果表达式主体只有一条语句，那么可以省略包含主体的大括号；另外，在Lambda表达式主体中允许有返回值，当只有一条return语句时，也可以省略return关键字。  \r\n  了解了Lambda表达式的语法后，接下来编写一个示例文件对Lambda表达式的基本使用进行介绍，具体代码如下所示。\r\n```js\r\n 1	// 定义动物类接口\r\n 2	interface Animal { \r\n 3		void shout(); // 定义方法shout()\r\n 4	}\r\n 5	public class Example22 {\r\n 6		public static void main(String[] args) {\r\n 7	       String name = \"小花\"; \r\n 8	       // 1、匿名内部类作为参数传递给animalShout()方法\r\n 9		  animalShout(new Animal() { \r\n 10				 public void shout() { \r\n 11				    System.out.println(\"匿名内部类输出：\"+name+\"喵喵...\");\r\n 12				}\r\n 13		  });\r\n 14		  // 2、使用Lambda表达式作为参数传递给animalShout()方法\r\n 15	       animalShout(()-> System.out.println(\"Lambda表达式输出：\"\r\n 16	                                                   +name+\"喵喵...\"));\r\n 17		}\r\n 18	    // 创建一个animalShout()静态方法，接收接口类型的参数\r\n 19		public static void animalShout(Animal an) {\r\n 20			an.shout();  \r\n 21		}\r\n 22	}\r\n```  \r\n  运行结果下图所示。\r\n![alt](/article_img/lambda/1.jpg)\r\n  上述代码示例中，先定义了只有一个抽象方法的接口Animal，然后分别使用匿名内部类和Lambda表达式的方式实现了接口方法。从图中可以看出，使用匿名内部类和Lambda表达式都能实现接口中方法，但很显然使用Lambda表达式更加简洁和清晰。', '2018-11-27 00:00:00', NULL, '默认分类', '#2018 #Lambda表达式', 1, '/api/images/6.png', 4, NULL);
INSERT INTO `t_article` VALUES (7, '函数式接口', 'tom', '&emsp;&emsp;虽然Lambda表达式可以实现匿名内部类的功能，但在使用时却有一个局限，即接口中有且只有一个抽象方法时才能使用Lamdba表达式代替匿名内部类。这是因为Lamdba表达式是基于函数式接口实现的，所谓函数式接口是指有且仅有一个抽象方法的接口，Lambda表达式就是Java中函数式编程的体现，只有确保接口中有且仅有一个抽象方法，Lambda表达式才能顺利地推导出所实现的这个接口中的方法。  \r\n&emsp;&emsp;在JDK 8中，专门为函数式接口引入了一个@FunctionalInterface注解，该注解只是显示的标注了接口是一个函数式接口，并强制编辑器进行更严格的检查，确保该接口是函数式接口，如果不是函数式接口，那么编译器就会报错，而对程序运行并没有实质上的影响。  \r\n&emsp;&emsp;接下来通过一个案例来演示函数式接口的定义与使用，示例代码如下所示。\r\n```js\r\n 1	// 定义无参、无返回值的函数式接口\r\n 2	@FunctionalInterface\r\n 3	interface Animal {\r\n 4		void shout();\r\n 5	}\r\n 6	// 定义有参、有返回值的函数式接口\r\n 7	interface Calculate {\r\n 8		int sum(int a, int b);\r\n 9	}\r\n 10	public class Example23 {\r\n 11		public static void main(String[] args) {\r\n 12		   // 分别两个函数式接口进行测试\r\n 13		   animalShout(() -> System.out.println(\"无参、无返回值的函数式接口调用\"));\r\n 14		   showSum(10, 20, (x, y) -> x + y);\r\n 15		}\r\n 16		// 创建一个动物叫的方法，并传入接口对象Animal作为参数\r\n 17		private static void animalShout(Animal animal) {\r\n 18			animal.shout();\r\n 19		}\r\n 20		// 创建一个求和的方法，并传入两个int类型以及接口Calculate类型的参数\r\n 21		private static void showSum(int x, int y, Calculate calculate) {\r\n 22		   System.out.println(x + \"+\" + y + \"的和为：\" + calculate.sum(x, y));\r\n 23		}\r\n 24	}\r\n```  \r\n&emsp;&emsp;运行结果如下图所示。\r\n\r\n![alt](/article_img/lambda/2.jpg)\r\n&emsp;&emsp;上述代码示例中，先定义了两个函数式接口Animal和Calculate，然后在测试类中分别编写了两个静态方法，并将这两个函数式接口以参数的形式传入，最后在main()方法中分别调用这两个静态方法，并将所需要的函数式接口参数以Lambda表达式的形式传入。从图中可以看出，程序中函数式接口的定义和使用完全正确。\r\n', '2018-12-01 00:00:00', NULL, '默认分类', '#接口 #函数式接口', 1, '/api/images/5.png', 4, NULL);
INSERT INTO `t_article` VALUES (8, 'JDK 8——聚合操作', 'tom', '&emsp;&emsp;在Java8版本中，JDK包含许多聚合操作（如平均值，总和，最小，最大，和计数），返回一个计算流stream的聚合结果。这些聚合操作被称为聚合操作。JDK除返回单个值的聚合操作外，还有很多聚合操作返回一个collection集合实例。很多的reduce操作执行特定的任务，如求平均值或按类别分组元素。  \r\n\r\n**1. 聚合操作简介**\r\n\r\n  在开发中，多数情况下会涉及到对集合、数组中元素的操作，在JDK 8之前都是通过普通的循环遍历出每一个元素，然后还会穿插一些if条件语句选择性的对元素进行查找、过滤、修改等操作，这种原始的操作方法虽然可行，但是代码量较大并且执行效率较低。  \r\n  为此，JDK 8中新增了一个Stream接口，该接口可以将集合、数组的中的元素转换为Stream流的形式，并结合Lambda表达式的优势来进一步简化集合、数组中元素的查找、过滤、转换等操作，这一新功能就是JDK 8中的聚合操作。  \r\n  在程序中，使用聚合操作没有绝对的语法规范，根据实际操作流程，主要可以分为以下3个步骤：  \r\n  （1）将原始集合或者数组对象转换为Stream流对象；  \r\n  （2）对Stream流对象中的元素进行一系列的过滤、查找等中间操作（Intermediate Operations），然后仍然返回一个Stream流对象；  \r\n  （3）对Stream流进行遍历、统计、收集等终结操作（Terminal Operation），获取想要的结果。  \r\n  接下来，就根据上面聚合操作的3个步骤，通过一个案例来演示聚合操作的基本用法，具体示例代码如下所示。\r\n```js\r\n 1	import java.util.*;\r\n 2	import java.util.stream.Stream;\r\n 3	public class Example31 {\r\n 4		public static void main(String[] args) {\r\n 5	          // 创建一个List集合对象\r\n 6			List<String> list = new ArrayList<>(); \r\n 7			list.add(\"张三\");\r\n 8			list.add(\"李四\");\r\n 9			list.add(\"张小明\");\r\n 10			list.add(\"张阳\");\r\n 11			// 1、创建一个Stream流对象\r\n 12			Stream<String> stream = list.stream();\r\n 13			// 2、对Stream流中的元素分别进行过滤、截取操作\r\n 14		       Stream<String> stream2 = stream.filter(i -> i.startsWith(\"张\"));\r\n 15			Stream<String> stream3 = stream2.limit(2);\r\n 16			// 3、对Stream流中的元素进行终结操作，进行遍历输出\r\n 17			stream3.forEach(j -> System.out.println(j));\r\n 18			System.out.println(\"=======\");\r\n 19	         // 通过链式表达式的形式完成聚合操作\r\n 20			list.stream().filter(i -> i.startsWith(\"张\"))\r\n 21						 .limit(2)\r\n 22						 .forEach(j -> System.out.println(j));\r\n 23		}\r\n 24	}\r\n``` \r\n   运行结果如下图所示。\r\n![alt](/article_img/lambda/3.jpg)\r\n  上述示例代码中，先创建了一个List集合，然后根据聚合操作的3个步骤实现了集合对象的聚合操作，对集合中的元素使用Stream流的形式进行过滤（filter）、截取（limit），并进行遍历输出。其中第12~17行代码分步骤详细展示了聚合操作，而第20~22行代码是使用了链式表达式（调用有返回值的方法时不获取返回值而是直接再调用另一个方法）实现了聚合操作，该表达式的语法格式更简洁、高效，这种链式调用也被称为操作管道流。\r\n\r\n**2. 创建Stream流对象**  \r\n  在上一小节中，介绍了聚合操作的主要使用步骤，其中首要解决的问题就是创建Stream流对象。聚合操作针对的就是可迭代数据进行的操作，如集合、数组等，所以创建Stream流对象其实就是将集合、数组等通过一些方法转换为Stream流对象。  \r\n  在Java中，集合对象有对应的集合类，可以通过集合类提供的静态方法创建Stream流对象，而数组数据却没有对应的数组类，所以必须通过其他方法创建Stream流对象。针对不同的源数据，Java提供了多种创建Stream流对象的方式，分别如下：  \r\n  （1）所有的Collections集合都可以使用stream()静态方法获取Stream流对象；  \r\n  （2）Stream接口的of()静态方法可以获取基本类型包装类数组、引用类型数组和单个元素的Stream流对象；  \r\n  （3）Arrays数组工具类的stream()静态方法也可以获取数组元素的Stream流对象。  \r\n  接下来，通过一个案例来学习聚合操作中如何创建Stream流对象，具体示例代码如下所示。\r\n```js\r\n 1	import java.util.*;\r\n 2	import java.util.stream.Stream;\r\n 3	public class Example32 {\r\n 4		public static void main(String[] args) {\r\n 5	          // 创建一个数组\r\n 6			Integer[] array = { 9, 8, 3, 5, 2 };       \r\n 7	          // 将数组转换为List集合\r\n 8			List<Integer> list = Arrays.asList(array); \r\n 9			// 1、使用集合对象的stream()静态方法创建Stream流对象\r\n 10			Stream<Integer> stream = list.stream();\r\n 11			stream.forEach(i -> System.out.print(i+\" \"));\r\n 12			System.out.println();\r\n 13			// 2、使用Stream接口的of()静态方法创建Stream流对象\r\n 14			Stream<Integer> stream2 = Stream.of(array);\r\n 15			stream2.forEach(i -> System.out.print(i+\" \"));\r\n 16			System.out.println();\r\n 17			// 3、使用Arrays数组工具类的stream()静态方法创建Stream流对象\r\n 18			Stream<Integer> stream3 = Arrays.stream(array);\r\n 19			stream3.forEach(i -> System.out.print(i+\" \"));\r\n 20		}\r\n 21	}\r\n```  \r\n  运行结果如下图所示。\r\n![alt](/article_img/lambda/4.jpg)\r\n  上述示例代码中，先创建了一个数组和一个集合，然后通过三种方式实现了Stream流对象的创建，并通过Stream流对象的forEach()方法结合Lambda表达式完成了集合和数组中元素的遍历。  \r\n\r\n**小提示：**  \r\n  在JDK 8中，只针对单列集合Collections接口对象提供了stream()静态方法获取Stream流对象，并未对Map集合提供相关方法获取Stream流对象，所以想要用Map集合创建Stream流对象必须先通过Map集合的keySet()、values()、entrySet()等方法将Map集合转换为单列Set集合，然后再使用单列集合的stream()静态方法获取对应键、值集合的Stream流对象。\r\n\r\n', '2018-12-02 00:00:00', NULL, '默认分类', '#JDK 8 #聚合操作', 1, '/api/img/images/4.png', 4, NULL);
INSERT INTO `t_article` VALUES (9, '虚拟化容器技术——Docker运行机制介绍', 'tom', '  Docker是一个开源的应用容器引擎，它基于go语言开发，并遵从Apache2.0开源协议。使用Docker可以让开发者封装他们的应用以及依赖包到一个可移植的容器中，然后发布到任意的Linux机器上，也可以实现虚拟化。Docker容器完全使用沙箱机制，相互之间不会有任何接口，这保证了容器之间的安全性。  \r\n\r\n**1. Docker的引擎介绍**\r\n\r\n  Docker Engine（Docker引擎）是Docker的核心部分，使用的是客户端-服务器（C/S）架构模式，其主要组成部分如下图所示。\r\n![alt](/article_img/docker/1.png)\r\n  从上图可以看出，Docker Engine中包含了三个核心组件（docker CLI、REST API和docker daemon），这三个组件的具体说明如下：  \r\n  ①docker CLI（command line interface）：表示Docker命令行接口，开发者可以在命令行中使用Docker相关指令与Docker守护进程进行交互，从而管理诸如image（镜像）、container（容器）、network（网络）和data volumes（数据卷）等实体。  \r\n  ②REST API：表示应用程序API接口，开发者通过该API接口可以与Docker的守护进程进行交互，从而指示后台进行相关操作。  \r\n  ③docker daemon：表示Docker的服务端组件，他是Docker架构中运行在后台的一个守护进程，可以接收并处理来自命令行接口及API接口的指令，然后进行相应的后台操作。  \r\n  对于开发者而言，既可以使用编写好的脚本文件通过REST API来实现与Docker进程交互，又可以直接使用Docker相关指令通过命令行接口来与Docker进程交互，而其他一些Docker应用则是通过底层的API和CLI进行交互的。\r\n\r\n**2. Docker的架构介绍**\r\n\r\n  了解了Docker内部引擎及作用后，我们还需要通过Docker的具体架构，来了解Docker的整个运行流程。接下来借助Docker官网的架构图来对Docker架构进行详细说明，如下图所示。\r\n![alt](/article_img/docker/2.jpg)\r\n  从图中可以看出，Docker架构主要包括Client、DOCKER_HOST和Register三部分，关于这三部分的具体说明如下。  \r\n&emsp;&emsp;**（1）Client（客户端）**  \r\n  Client即Docker客户端，也就是上一小节Docker Engine中介绍的docker CLI。开发者通过这个客户端使用Docker的相关指令与Docker守护进程进行交互，从而进行Docker镜像的创建、拉取和运行等操作。  \r\n&emsp;&emsp;**（2）DOCKER_HOST（Docker主机）**  \r\n  DOCKER_HOST即Docker内部引擎运行的主机，主要指Docker daemon（Docker守护进程）。可以通过Docker守护进程与客户端还有Docker的镜像仓库Registry进行交互，从而管理Images（镜像）和Containers（容器）等。  \r\n&emsp;&emsp;**（3）Registry（注册中心）**  \r\n  Registry即Docker注册中心，实质就是Docker镜像仓库，默认使用的是Docker官方远程注册中心Docker Hub，也可以使用开发者搭建的本地仓库。Registry中包含了大量的镜像，这些镜像可以是官网基础镜像，也可以是其他开发者上传的镜像。  \r\n  我们在实际使用Docker时，除了会涉及到图中的三个主要部分外，还会涉及到很多Docker Objects（Docker对象），例如Images（镜像）、Containers（容器）、Networks（网络）、Volumes（数据卷）、Plugins（插件）等。其中常用的两个对象Image和Containers的说明如下。  \r\n  ①Images（镜像）  \r\n  Docker 镜像就是一个只读的模板，包含了一些创建Docker容器的操作指令。通常情况下，一个Docker镜像是基于另一个基础镜像创建的，并且新创建的镜像会额外包含一些功能配置。例如：开发者可以依赖于一个Ubuntu的基础镜像创建一个新镜像，并可以在新镜像中安装Apache等软件或其它应用程序。  \r\n  ②Containers（容器）  \r\n  Docker容器属于镜像的一个可运行实例（镜像与容器的关系其实与Java中的类与对象相似），开发者可以通过API接口或者CLI命令行接口来创建、运行、停止、移动、删除一个容器，也可以将一个容器连接到一个或多个网络中，将数据存储与容器进行关联。\r\n\r\n\r\n\r\n', '2018-12-03 00:00:00', NULL, '默认分类', '#虚拟化容器 #Docker #运行机制', 1, '/api/images/3.png', 4, NULL);
INSERT INTO `t_article` VALUES (10, 'Docker常用客户端指令介绍', 'tom', '  在使用Docker之前，首先会为对应的项目编写Dockerfile镜像构建文件，然后通过Docker的相关指令进行镜像构建，完成镜像的构建后，就可以使用这些项目镜像进行启动测试了。所以要想知道如何使用Docker来执行这些Dockerfile镜像构建文件，还需要学习Docker客户端的常用指令，本篇文章将对Docker客户端的常用指令进行详细讲解。  \r\n\r\n**1.列出镜像**  \r\n  通过docker images指令可以查看本地镜像列表中已有的镜像，具体使用方式如下。\r\n```js\r\n$ docker images\r\n```  \r\n  执行上述指令后，系统会将所有本地镜像都展示出来，如下图所示。\r\n![alt](/article_img/docker/3.png)\r\n  从图中可以看出，系统终端将本地镜像列表中的3个镜像分5列进行了展示，每一列的具体含义如下。  \r\n  ●REPOSITORY：镜像名称。  \r\n  ●TAG：镜像的参数，类似于版本号，默认是latest。  \r\n  ●IMAGE ID：镜像ID，是唯一值。此处看到的是一个长度为12的字符串，实际上它是64位完整镜像ID的缩写形式。  \r\n  ●CREATED：距今创建镜像的时间。  \r\n  ●SIZE：镜像大小。    \r\n\r\n**2.搜索镜像**  \r\n  想知道在Docker Hub中包含了哪些镜像，除了可以登录Docker Hub，在官网中心进行查看外，还可以直接在Docker客户端进行查询。例如想要查询Ubuntu镜像，可以使用如下指令。\r\n```js\r\n$ docker search ubuntu\r\n```  \r\n  执行上述指令后，系统终端就会将搜索到的有关Ubuntu的镜像展示出来，如下图所示。\r\n![alt](/article_img/docker/4.png)\r\n  从图所示的结果可以看出，系统终端分5列将搜索到的Ubuntu相关镜像都列举出来了，这5列的具体含义如下。  \r\n  ●NAME：表示镜像的名称，这里有两种格式的名称，其中不带有“/”的表示官方镜像，而带有“/”的表示其他用户的公开镜像。公开镜像“/”前面是用户在Docker Hub上的用户名（唯一），后面是对应的镜像名；官方镜像与用户镜像，除了从镜像名称上可以区分外，还可以通过第4列的OFFICIAL声明中看出（该列下内容为OK表示官方镜像）。  \r\n  ●DESCRIPTION：表示镜像的描述，这里只显示了一小部分。  \r\n  ●STARS：表示该镜像的收藏数，用户可以在Docker Hub上对镜像进行收藏，一般可以通过该数字反应出该镜像的受欢迎程度。  \r\n  ●OFFICIAL：表示是否为官方镜像。  \r\n  ●AUTOMATED：表示是否自动构建镜像。例如，用户可以将自己的Docker Hub绑定到如Github上，当代码提交更新后，可以自动构建镜像。   \r\n \r\n**3.拉取镜像**  \r\n  通过docker pull指令可以拉取仓库镜像到本地（默认都是拉取Docker Hub仓库镜像，也可以指定“IP+端口”拉取某个Docker机器上的私有仓库镜像），具体使用方式如下。\r\n```js\r\n$ docker pull ubuntu\r\n```  \r\n  执行上述指令后，Docker会自动从Docker Hub上下载最新版本的Ubuntu到本地，当然也可以使用以下指令拉取指定版本的镜像到本地，具体指令如下。\r\n```js\r\n$ docker pull ubuntu:14.04\r\n```  \r\n**4.构建镜像**  \r\n  除了可以通过docker pull指令从仓库拉取镜像外，还可以通过docker build指令构建Docker镜像，通常情况下都是通过Dockerfile文件来构建镜像的。  \r\n  这里假设linux系统home目录下/shitou/workspace/dockerspace文件夹中编写有对应的Dockerfile文件，则构建镜像直立示例如下所示。 \r\n```js\r\n$ docker build -t hellodocker3 /home/shitou/workspace/dockerspace/.\r\n```\r\n**5.删除镜像**  \r\n  当本地存放过多不需要的镜像时，可以通过docker rmi指令将其删除。在删除镜像时，需要指定镜像名称或镜像ID。删除镜像的使用方式如下。\r\n```js\r\n$ docker rmi -f hellodocker2 hellodocker3\r\n```  \r\n  上述指令中，docker rmi表示删除镜像，-f表示进行强制删除，而hellodocker2和hellodocker3分别表示需要删除的镜像名称，这里同时删除两个镜像。除了根据名称删除镜像外，还也可以根据镜像ID来删除镜像，只是这里如果指定了删除ID为23c617a866d4的镜像后，会同时删除hellodocker、hellodocker2和hellodocker3三个镜像。  \r\n  需要特别强调的是，在进行镜像删除操作时，如果是通过镜像ID进行镜像删除，那么由该镜像创建的容器必须提前删除或停止。另外，在通过镜像名称操作镜像时，如果出现镜像重名的情况，必须在镜像名称后面指定镜像标签tag参数来确保唯一性。\r\n\r\n**6.创建并启动容器**  \r\n  Docker镜像主要用于创建容器，可以使用docker run指令创建并启动容器，具体使用方式如下。\r\n```js\r\n$ docker run -d -p 5000:80 --name test hellodocker\r\n```  \r\n  上述创建并启动容器的指令略微复杂，具体分析如下。  \r\n  ●docker run：表示创建并启动一个容器，而后面的hellodocker就表示要启动运行的镜像名称；  \r\n  ●-d：表示容器启动时在后台运行；  \r\n  ●-p 5000:80：表示将容器内暴露的80端口映射到宿主机指定的5000端口，也可以将-p 5000:80更改为-P来映射主机的随机端口（注意p字母的大小写）；  \r\n  ●--name test：表示为创建后的容器指定名称为test，如果没有该参数配置，则生成的容器会设置一个随机名称。  \r\n  docker run命令是Docker操作中较为复杂的一个，它可以携带多个参数和参数，我们可以通过docker run --help指令进行查看，其中有些参数如-e、-v和-w等都可以在Dockerfile文件中预先声明。 \r\n \r\n**7.列出容器**  \r\n  生成容器后，可以通过docker ps指令查看当前运行的所有容器，具体使用方式如下。\r\n```js\r\n$ docker ps\r\n```  \r\n  执行上述命令后，会将所有当前运行的容器都展示出来，具体如下图所示。\r\n![alt](/article_img/docker/5.png)\r\n  从图中可以看出，系统终端通过7列对当前的正在运行的一个容器进行了展示，图中每一列的具体含义如下。  \r\n  ●CONTAINER ID：表示生成的容器ID；  \r\n  ●IMAGE：表示生成该容器的镜像名称；  \r\n  ●COMMAND：表示启动容器时运行的命令，Docker要求在启动容器时必须运行一个命令；  \r\n  ●CREATED：表示容器创建的时间；  \r\n  ●STATUS：表示容器运行状态，例如Up表示运行中，Exited表示已停止；  \r\n  ●PORTS：表示容器内部暴露的端口映射到主机的端口；  \r\n  ●NAMES：表示生成容器的名称，由Docker引擎自动生成，可以像上述示例中使用--name参数指定生成容器的名称。  \r\n  另外，docker ps指令运行过程中可以指定多个参数，还可以通过docker ps --help指令对ps指令的其他信息进行查看。\r\n\r\n**8.删除容器**  \r\n  当不需要使用容器时，则可以使用docker rm指令删除已停止的容器，具体使用方式如下。\r\n```js\r\n$ docker rm f0c9a8b6e8c5\r\n```  \r\n  需要注意的是，上述指令只能删除已经停止运行的容器，而不能删除正在运行的容器。如果想要删除正在运行的容器，则需要添加-f参数强制删除，具体使用方式如下。\r\n```js\r\n$ docker rm -f f0c9a8b6e8c5\r\n```  \r\n  当需要删除的容器过多时，如果还一个个的删除就略显麻烦了，此时可以通过如下指令将全部容器删除。\r\n```js\r\n$ docker rm -f $(docker ps -aq)\r\n```  \r\n  上述指令中，首先会通过$(docker ps -aq)获取所有容器的ID，然后通过docker rm -f指令进行强制删除。如果开发者有自己特殊的删除需求，可以根据前面docker ps指令进行组装来获取需要删除的容器ID。  \r\n  Docker提供的操作指令远不止这些，这里就不一一列举了，想要了解更多Docker的操作指令，可以通过docker --help指令进行查看。\r\n\r\n\r\n', '2018-12-05 00:00:00', NULL, '默认分类', '#Docker #客户端指令', 1, '/api/images/2.png', 4, NULL);
INSERT INTO `t_article` VALUES (11, 'Docker数据管理介绍', 'tom', '  当我们对容器进行相关操作时，产生的一系列数据都会存储在容器中，而Docker内部又是如果管理这些数据的呢？本篇文章将针对Docker数据管理的一些知识进行介绍。\r\n  \r\n**1. Docker数据存储机制**  \r\n  使用Docker时，我们操作的都是镜像和由镜像生成的容器，所以想要更好的了解Docker内部的数据存储机制，就必须从镜像、容器与数据存储的关系出发。  \r\n  Docker镜像是通过读取Dockerfile文件中的指令构建的，Dockerfile中的每条指令都会创建一个镜像层，并且每层都是只读的，这一系列的镜像层就构成了Docker镜像。接下来以一个Dockerfile文件为例进行说明，具体如下列代码示例所示。\r\n```js\r\n 1	FROM ubuntu:16.04\r\n 2	COPY . /app\r\n 3	RUN make /app\r\n 4	CMD python /app/app.py\r\n```  \r\n   上述文件示例中的Dockerfile包含了4条指令，每条指令都会创建一个镜像层，其中每一层与前一层都有所不同，并且是层层叠加的。通过镜像构建容器时，会在镜像层上增加一个容器层（即可写层），所有对容器的更改都会写入容器层，这也是Docker默认的数据存储方式。  \r\n  下面通过一个效果图进行说明，具体如下图所示。\r\n![alt](/article_img/docker/6.png)\r\n  从图中可以看出，Docker容器和镜像之间的主要区别是顶部的容器层，而所有对容器中数据的添加、修改等操作都会被存储在容器层中。当容器被删除时，容器层也会被删除，其中存储的数据会被一同删除，而下面的镜像层却保持不变。  \r\n  由于所有的容器都是通过镜像构建的，所以每个容器都有各自的容器层，对于容器数据的更改就会保存在各自的容器层中。也就是说，由同一个镜像构建的多个容器，它们会拥有相同的底部镜像层，而拥有不同的容器层，多个容器可以访问相同的镜像层，并且有自己的独立数据状态。具体说明如下图所示。 \r\n![alt](/article_img/docker/7.png)\r\n  从图中可以看出，基于同一个镜像构建的多个容器可以共享该镜像层，但是多个容器想要共享相同的数据，就需要将这些数据存储到容器之外的地方，而这种方式就是下一节要提到的Docker volume数据外部挂载机制。  \r\n\r\n**2. Docker数据存储方式**    \r\n  在默认情况下，Docker中的数据都是存放在容器层的，但是这样存储数据却有较多的缺陷，具体表现如下。    \r\n  ●当容器不再运行时，容器中的数据无法持久化保存，如果另一个进程需要这些数据，那么将很难从容器中获取数据；  \r\n  ●容器层与正在运行的主机紧密耦合，不能轻易地移动数据；  \r\n  ●容器层需要一个存储驱动程序来管理文件系统，存储驱动程序提供了一个使用Linux内核的联合文件系统，这种额外的抽象化降低了性能。  \r\n  基于上述种种原因，多数情况下Docker数据管理都不会直接将数据写入容器层，而是使用另一种叫做Docker volume数据外部挂载的机制进行数据管理。  \r\n  针对Docker volume数据外部挂载机制，Docker提供了三种不同的方式将数据从容器映射到Docker宿主机，他们分别为：volumes（数据卷）、bind mounts（绑定挂载）和tmpfs mounts（tmpfs挂载）。这三种数据管理方式的具体选择，需要结合实际情况进行考虑，其中的volumes数据卷是最常用也是官方推荐的数据管理方式。无论选择使用哪种数据管理方式，数据在容器内看起来都一样的，而在容器外则会被被挂载到文件系统中的某个目录或文件中。    \r\n  下面通过一张图来展示数据卷、绑定挂载和tmpfs挂载之间的差异，如下图所示。  \r\n![alt](/article_img/docker/8.png)\r\n  从图中可以看出，Docker提供的三种数据管理方式略有不同，具体分析如下。  \r\n  ●volumes：存储在主机文件系统中（在Linux系统下是存在于/var/lib/Docker/volumes/目录），并由Docker管理，非Docker进程无法修改文件系统的这个部分。  \r\n  ●bind mounts：可以存储在主机系统的任意位置，甚至可能是重要的系统文件或目录，在Docker主机或容器上的非Docker进程可以对他们进行任意修改。  \r\n  ●tmpfs mounts：只存储在主机系统的内存中，并没有写入到主机的文件系统中。\r\n\r\n\r\n', '2018-12-07 00:00:00', NULL, '默认分类', '#Docker #数据管理', 1, '/api/images/1.png', 4, NULL);
INSERT INTO `t_article` VALUES (12, 'Spring Boot 2 权威发布', '123', '  如果这两天登录 [https://start.spring.io/ ](https://start.spring.io/ )就会发现，Spring Boot 默认版本已经升到了 2.1.0。这是因为 Spring Boot 刚刚发布了 2.1.0 版本，我们来看下 Spring Boot 2 发布以来第一个子版本都发布了哪些内容？  \r\n\r\n**2.1 中的新特性**     \r\n  ●将spring-boot-starter-oauth2-oidc-client重命名为spring-boot-starter-oauth2-client命名更简洁  \r\n  ●添加 OAuth2 资源服务 starter，OAuth2 一个用于认证的组件  \r\n  ●支持 ConditionalOnBean 和 ConditionalOnMissingBean 下的参数化容器  \r\n  ●自动配置 applicationTaskExecutor bean 的延迟加载来避免不必要的日志记录  \r\n  ●将 DatabaseDriver＃SAP 重命名为 DatabaseDriver  \r\n  ●跳过重启器不仅适用于 JUnit4，也适用于 JUnit5  \r\n  ●在 Jest HealthIndicator 中使用集群端点  \r\n  ●当 DevTools 禁用重启时添加日志输出  \r\n  ●添加注解：@ConditionalOnMissingServletFilter提高 Servlet Filters 的自动装配。\r\n  \r\n**2.1 中的组件升级**  \r\n  ●升级 Hibernate 5.3，Hibernate 的支持升级到了 5.3  \r\n  ●升级 Tomcat 9 ，支持最新的 tomcat 9  \r\n  ●支持 Java 11，Java 现在更新越来越快，Spring 快赶不上了    \r\n  ●升级 Thymeleaf Extras Springsecurity 到 3.0.4.RELEASE ，thymeleaf-extras-springsecurity 是 Thymeleaf 提供集成 Spring Security 的组件  \r\n  ●升级 Joda Time 2.10.1，Joda-Time， 面向 Java 应用程序的日期/时间库的替代选择，Joda-Time 令时间和日期值变得易于管理、操作和理解。  \r\n  ●升级 Lettuce 5.1.2.RELEASE ，Lettuce 前面说过，传说中 Redis 最快的客户端。  \r\n  ●升级 Reactor Californium-SR2 ，Californium 是物联网云服务的 Java COAP 实现。因此，它更专注的是可扩展性和可用性而不是像嵌入式设备那样关注资源效率。不过，Californium 也适合嵌入式的 JVM。  \r\n  ●升级 Maven Failsafe Plugin 2.22.1 ，Maven 中的测试插件。  \r\n  ●升级 Flyway 5.2.1 ， Flyway是一款开源的数据库版本管理工具  \r\n  ●升级 Aspectj 1.9.2 ，AspectJ 是 Java 中流行的 AOP（Aspect-oriented Programming）编程扩展框架，是 Eclipse 托管给 Apache 基金会的一个开源项目。  \r\n  ●升级 Mysql 8.0.13 ，Mysql 支持到 8。  \r\n  ●...  \r\n&emsp;&emsp;更多的详细内容可以参考这里：[Spring Boot 2.1 Release Notes](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-2.1-Release-Notes)\r\n', '2018-12-11 00:00:00', '2025-11-19 00:00:00', '默认分类', '#Spring Boot 2', 1, '/api/images/f593a479-539b-4610-a236-1d6567e0cb8f.jpg', 5, NULL);
INSERT INTO `t_article` VALUES (13, '111111', '123', '', '2025-10-26 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (14, '123', '123', '', '2025-10-26 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (15, '234', '123', '<p>234</p>', '2025-10-26 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (16, '12234', '123', '', '2025-10-27 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (17, '123', '李四', '<p><img src=\"/api/images/68bfaff6-608f-473f-8f35-b9430446ca76.jpg\" alt=\"\" width=\"500\" height=\"375\"></p>\n<p>66666</p>', '2025-11-27 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 2, NULL);
INSERT INTO `t_article` VALUES (18, '2202020202', '李四', '<p><img src=\"/api/images/68bfaff6-608f-473f-8f35-b9430446ca76.jpg\" alt=\"\" width=\"500\" height=\"375\"></p>\n<p>66666</p>', '2025-10-27 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 2, NULL);
INSERT INTO `t_article` VALUES (19, 'we', '李四', '<p>123456789<img src=\"/api/images/f07d3fe0-18c0-4a9b-aa4c-177cfb7f6034.jpg\" alt=\"\" width=\"500\" height=\"375\"></p>', '2025-10-27 00:00:00', '2025-12-16 00:00:00', '默认分类', '', 1, '/api/images/1.png', 2, NULL);
INSERT INTO `t_article` VALUES (21, '123', '李四', '<p>123</p>', '2025-12-16 00:00:00', NULL, '默认分类', '', 1, '/api/images/6.png', 2, NULL);
INSERT INTO `t_article` VALUES (22, '这是第几篇文章呢', '李四', '<p>111</p>', '2025-12-16 00:00:00', NULL, '默认分类', '', 1, '/api/images/6.png', 2, NULL);
INSERT INTO `t_article` VALUES (23, '好多bug...', '李四', '好多bug...', '2025-12-17 23:27:12', '2025-12-17 23:27:56', '默认分类', '', 1, '', 2, NULL);
INSERT INTO `t_article` VALUES (24, '有个奇怪的bug', 'zzt', '<p>读取id为22以前(包括22)的文章可以正常读取但是22以后的就不能了</p>', '2025-12-17 22:46:34', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (25, '2121', 'zzt', '<p>2121</p>', '2025-12-17 23:52:15', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (26, '测试', 'zzt', '<p>实测</p>', '2025-12-17 23:55:10', '2025-12-18 05:40:43', '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (27, '123', 'zzt', '<p>23</p>', '2025-12-18 00:15:27', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (28, '123', 'zzt', '<p>23</p>', '2025-12-18 00:15:55', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (29, '新年快乐', 'zzt', '<p>新年快乐!!!</p>', '2026-01-02 04:13:52', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (30, 'IP测试', 'zzt', '<p>新增了显示ip功能,看看能不能成功</p>', '2026-01-02 17:43:31', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (31, '123', 'admin', '<p>1234567</p>', '2026-01-04 02:14:49', NULL, '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (32, '我再来发布一篇看看', NULL, '<p>现在是2026.01.04.02:17</p>', '2026-01-04 02:18:33', NULL, '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (33, '我再再来发布一篇看看', NULL, '<p>现在是2026.01.04.02:20</p>', '2026-01-04 02:20:38', NULL, '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (34, '我看看普通用户能不能创建文章', NULL, '<p>这里是</p>', '2026-01-04 02:23:38', NULL, '默认分类', '', 1, '/api/images/6.png', 5, NULL);
INSERT INTO `t_article` VALUES (35, '我现在要来验证一下分类标签功能是否能正常使用', NULL, '<p>希望可以</p>', '2026-01-04 02:52:44', NULL, '技术/后端/Java', '#Java #技术实现', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (36, '为什么这个图片显示不出来了', NULL, '<p><img src=\"/api/images/0a470eb5-6588-407d-bdd7-bdd88b0d9f39.png\" alt=\"\">现在我上传了一篇带图片的文章</p>', '2026-01-04 03:15:25', NULL, '技术/前端/Vue3', '#bug #交流', 1, '/api/images/d9fbf556-a0e6-4528-96a2-e43c0bc8daa0.png', 1, NULL);
INSERT INTO `t_article` VALUES (37, '测试', NULL, '<p>test</p>', '2026-01-04 08:28:19', NULL, '技术/SpringBoot', '', 1, '/api/images/6.png', 2, NULL);
INSERT INTO `t_article` VALUES (38, 'bug一个', NULL, '<p>为什么无法自动创建文章分类</p>', '2026-01-04 09:05:44', NULL, '默认分类', '#bug #', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (39, '文章必须加标题...', NULL, '', '2026-01-04 09:09:19', '2026-01-04 13:18:33', '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (40, '测试', NULL, '<p>测试一下根据分类创建文章能不能运行</p>', '2026-01-04 09:12:52', NULL, '技术/SpringBoot', '#test #测试', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (41, 'MOONARY', NULL, '<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"/api/images/86eda4c3-f738-4e87-924f-1890373f3f0e.jpg\" alt=\"\" width=\"737\" height=\"983\"></p>\n<p>好喝,就是有一点贵</p>\n<p>&nbsp;</p>', '2026-01-04 10:09:39', '2026-01-04 13:11:40', '生活/美食', '#coffee #美饮 #咖啡 #Hong Kong #香港 #抹茶', 1, '/api/images/f25acfa7-cad6-46c4-a403-5ecee391fd21.jpg', 1, '香港');
INSERT INTO `t_article` VALUES (42, '测试一下定位能否正常工作', NULL, '<p>我现在在东莞理工学院松山湖校区莞逸9栋704</p>', '2026-01-04 13:22:19', NULL, '技术', '#test #测试', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (54, '听说有草稿箱功能?', 'admin', '<p>123</p>', '2026-01-04 21:43:41', NULL, '默认分类', '', 1, '/api/images/6.png', 1, '平壤市');
INSERT INTO `t_article` VALUES (55, '2026.01.04工作总结', 'zzt', '<p>1.新增仪表盘功能(明天起床优化打磨)</p>\n<p>2.新增点赞功能</p>\n<p>3.新增发布文章可以加入定位功能</p>\n<p>4.新增沉浸阅读功能</p>\n<p>5.新增标签云功能(明天起床优化打磨)</p>\n<p>6.新增标签分类管理功能(同样缺少优化打磨)</p>\n<p>7.新增草稿箱功能</p>\n<p>8.优化主页文章封面样式排版</p>\n<p>9.合并阅读榜与点赞榜</p>\n<p>10.......</p>', '2026-01-04 23:38:22', NULL, '技术/SpringBoot', '#总结', 1, '/api/images/6.png', 6, '');
INSERT INTO `t_article` VALUES (56, '美方披露抓获马杜罗更多细节', '李四', '<p>新华社华盛顿1月3日电　美国总统特朗普3日宣布，美国在对委内瑞拉的行动中抓获委总统马杜罗及其夫人，并将他们带离委内瑞拉。美国媒体随后披露了此次行动的更多细节。</p>\n<p>美国哥伦比亚广播公司援引消息人士的话报道，马杜罗系被美军三角洲特种部队抓获。三角洲特种部队曾于2019年执行打死极端组织&ldquo;伊斯兰国&rdquo;最高头目阿布&middot;贝克尔&middot;巴格达迪的任务。</p>\n<p>特朗普在接受《纽约时报》电话采访时说，抓获马杜罗&ldquo;得益于周密的计划、精锐的部队和优秀的人员。这真是一次精彩的行动&rdquo;。</p>\n<p>当被《纽约时报》记者问及是否就此次行动寻求过国会授权以及对委内瑞拉下一步计划时，特朗普表示，他将于美国东部时间3日11时（北京时间4日0时）在海湖庄园举行新闻发布会，回答这些问题。</p>\n<p>委内瑞拉副总统德尔西&middot;罗德里格斯3日通过国家电视台表示，委政府不知道马杜罗及其夫人现在何处，&ldquo;我们要求提供他们活着的证据&rdquo;。罗德里格斯还说，美方行动造成委官员、士兵和平民丧生。</p>', '2026-01-05 07:49:38', NULL, '新闻/时政/国外', '#时政 #新闻', 1, '/api/images/6.png', 2, 'Venezuela');
INSERT INTO `t_article` VALUES (59, '国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', '李四', '<p><img class=\"picture-illustrating not-indent patt\" src=\"http://paper.people.com.cn/rmrb/pc/pic/202601/05/f44651e5-6925-4b2f-a4ad-940a7eeb8036.jpg\" width=\"469\" height=\"314\" data-toggle=\"tooltip\" data-original-title=\"&lt;p&gt;　　1月3日，一些美国民众聚集在白宫外，抗议美国对委内瑞拉发起大规模军事行动。&lt;/p&gt;&lt;p&gt;　　朱莉娅&middot;尼金森摄（影像中国）&lt;/p&gt;\"></p>\n<table class=\"pci_c\" width=\"400\">\n<tbody>\n<tr>\n<td>\n<p>1月3日，一些美国民众聚集在白宫外，抗议美国对委内瑞拉发起大规模军事行动。<br>　　朱莉娅&middot;尼金森摄（影像中国）</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>　　当地时间1月3日凌晨，美国对委内瑞拉发起大规模军事行动，突袭该国首都加拉加斯并强行控制总统马杜罗及其夫人。美国的军事行动造成包括委内瑞拉军人和平民在内至少40人死亡，多个国家和国际组织对此表示强烈谴责。中国外交部发言人表示，美方行径明显违反国际法和国际关系基本准则，违反《联合国宪章》宗旨和原则。中方呼吁美方确保马杜罗总统夫妇人身安全，立即释放马杜罗总统和夫人，停止颠覆委内瑞拉政权，通过对话谈判解决问题。</p>\n<p>　　&ldquo;美国妄图夺走委内瑞拉的石油、土地和财产，委人民决不会答应&rdquo;</p>\n<p>　　美军3日凌晨突袭委内瑞拉首都加拉加斯等地，强行控制马杜罗夫妇，用直升机将他们运至一艘军舰上。他们在经停关塔那摩美军基地后乘机飞往纽约。美国媒体预计，马杜罗下周将在纽约市的一处法院&ldquo;出庭&rdquo;，面临&ldquo;毒品恐怖主义阴谋罪、可卡因走私阴谋罪&rdquo;等多项指控。美军参谋长联席会议主席丹&middot;凯恩透露，美军为行动演练数月。</p>\n<p>　　美国总统特朗普3日上午举行新闻发布会称，美国将&ldquo;管理&rdquo;委内瑞拉直至实施&ldquo;安全&rdquo;过渡，让美国石油公司大举进军委内瑞拉并投资委能源基础设施。他还声称：&ldquo;我们将从（委内瑞拉）地下开采出大量的财富，这些财富将归委内瑞拉人民以及曾经在委内瑞拉的外国人所有。这些财富也将以赔偿这个国家给我们造成损失的形式流向美国。&rdquo;</p>\n<p>　　委内瑞拉多名政要强烈谴责美国的入侵行径。委内瑞拉副总统兼石油部长德尔西&middot;罗德里格斯3日下午在国家电视台发表讲话说，马杜罗是委内瑞拉&ldquo;唯一的总统&rdquo;，&ldquo;委内瑞拉永远不会成为任何国家的殖民地&rdquo;。委内瑞拉内政、司法与和平部长迪奥斯达多&middot;卡韦略在首都加拉加斯街头谴责道：&ldquo;他们对沉睡的民众发动了卑鄙、恶毒的袭击，懦夫般地袭击了民众。&rdquo;委最高法院院长罗德里格斯通过国家电视台宣读一份声明，谴责美国对委首都加拉加斯及其周边三个州的袭击公然违反国际法，尤其是《联合国宪章》。声明说，此次侵略&ldquo;旨在攫取委内瑞拉的战略资源&rdquo;，并呼吁国际社会共同努力维护拉丁美洲和加勒比地区的和平与稳定。</p>\n<p>　　3日晚，委内瑞拉最高法院通过国家电视台宣读决定，由罗德里格斯副总统代行国家元首职责，以保证行政连续性以及国家的全面防御。决定表示，鉴于马杜罗遭绑架造成的特殊情况，最高法院在总统被迫缺位期间采取了相应程序，以在目前面临外国侵略的情况下维护国家利益。</p>\n<p>　　美国政府此次军事行动在美国国内也引发诸多抗议和批评。3日，由反战组织&ldquo;即刻行动制止战争消除种族主义&rdquo;联盟发起的示威活动，在华盛顿、洛杉矶、波士顿等105个城市同步举行。纽约时报广场上，示威者高举委内瑞拉国旗，手持&ldquo;保卫委内瑞拉，释放马杜罗&rdquo;&ldquo;不要插手委内瑞拉事务&rdquo;&ldquo;反对向委内瑞拉开战&rdquo;等标语，高喊口号抗议。一名委内瑞拉裔示威者控诉：&ldquo;美国妄图夺走委内瑞拉的石油、土地和财产，委人民决不会答应！&rdquo;组织方声明指出，美国战争机器消耗大量纳税款，却给他国民众带来死亡和毁灭，美国人民不愿再卷入新的战争。</p>\n<p>　　美联社发表评论文章表示，这是自2003年美军入侵伊拉克以来，美国为实现外国政权更迭&ldquo;采取的最激进行动&rdquo;。在特朗普政府看来，要实现&ldquo;西半球优先&rdquo;，美国必须控制或对抗拉美地区的潜在反美力量。选择委内瑞拉作为突破口，美方意在产生震荡效应，对拉美其他国家产生战略威慑，进而扩张美国在拉美影响力和战略空间。</p>\n<p>　　美国宪法规定，任何战争行为均须经国会批准，但此次行动并未获得国会授权，甚至在启动后才通知国会工作人员。美国联邦众议员吉姆&middot;希姆斯表示，未看到任何证据能证明马杜罗执政构成的威胁足以成为未经授权动武的理由，政府应立即通报决策的法律依据及后续局势应对策略。联邦众议员格雷戈里&middot;米克斯谴责该行动&ldquo;违反国际法，将损害美国全球地位&rdquo;，警告此举可能使美国卷入同委内瑞拉的无限期冲突，破坏地区稳定。</p>\n<p>　　美国前副总统、前民主党总统候选人哈里斯表示，美国对委内瑞拉采取军事行动是&ldquo;错误且不明智的&rdquo;。美国曾多次发动以&ldquo;政权更迭&rdquo;或&ldquo;石油&rdquo;为目的的战争，这些战争往往被包装成&ldquo;力量的展示&rdquo;，最终却演变为混乱局面，让美国普通家庭为此付出代价。她强调，这种做法既不合法，也不会让美国&ldquo;更安全、更强大或让美国人民的生活更可负担&rdquo;。</p>\n<p>　　《纽约时报》刊登社论指出，美方以打击&ldquo;毒品恐怖主义&rdquo;为借口纯属荒谬。社论回顾美国历史上多次武力干预他国内政的恶果：耗时20年未能在阿富汗建立稳定政府，推翻利比亚政权导致该国分裂，2003年伊拉克战争的创伤至今未愈，而智利、古巴等拉美国家也曾因美国干预陷入动荡，警告此次行动可能重蹈覆辙。</p>\n<p>　　&ldquo;这次行动具有政治和经济动机，并对地区稳定构成严重威胁&rdquo;</p>\n<p>　　美国长期视拉丁美洲为自家&ldquo;后院&rdquo;，以各种名义干预拉美内政。1823年，时任美国总统门罗提出&ldquo;门罗主义&rdquo;，警告欧洲列强不要介入美洲事务。1983年，在美国干预下，格林纳达发生内部政变，格总理毕晓普等官员被杀害。上世纪80年代，美国还支持尼加拉瓜反政府武装对抗尼加拉瓜左翼桑地诺政府，直至桑地诺政府在1990年总统选举中落败。在特朗普第二个任期内，&ldquo;门罗主义&rdquo;高调回归美国外交政策核心。特朗普3日称，其政府对&ldquo;门罗主义&rdquo;已经&ldquo;多有超越&rdquo;，美国再也不会忘记&ldquo;门罗主义&rdquo;，并将长久&ldquo;主宰&rdquo;西半球。</p>\n<p>　　美国此次军事行动引发地区国家强烈抗议。巴西外交部3日发布声明说，总统卢拉重申此前立场，谴责美国袭击委内瑞拉并强行控制马杜罗及其夫人的行为。巴西执政党劳工党同日发布声明说，美国对委内瑞拉采取的行动可以被定性为对马杜罗及其夫人的&ldquo;绑架&rdquo;。&ldquo;这次行动具有政治和经济动机，并对地区稳定构成严重威胁&rdquo;，&ldquo;构成21世纪以来南美洲遭受的最严重侵略事件&rdquo;。</p>\n<p>　　古巴各界民众3日在美国驻古巴大使馆前的反帝广场举行集会，强烈谴责美国对委内瑞拉发动军事入侵。古共中央第一书记、古巴国家主席迪亚斯&mdash;卡内尔在集会上严厉谴责美国对委内瑞拉实施的&ldquo;国家恐怖主义行径&rdquo;，并要求立即释放委内瑞拉总统马杜罗及其夫人。他指出，美国的真正企图是攫取委内瑞拉的石油、土地和自然资源。迪亚斯&mdash;卡内尔说，美国对委内瑞拉的打击，是对主权国家的公然侵犯，也是对国际法的不可接受的破坏。</p>\n<p>　　乌拉圭外交部3日发布声明说，乌方严重关切委内瑞拉发生的事件，包括美国对委内瑞拉军事设施和民用基础设施的空袭，谴责对他国领土的军事干预行为，并重申各国应尊重国际法和《联合国宪章》。</p>\n<p>　　拉共体轮值主席国哥伦比亚外交部发布声明，对新近发生的针对委内瑞拉领土完整和政治自主权采取的武装行动表示谴责。声明指出，哥伦比亚重申对地区和平与安全、国家主权以及《联合国宪章》原则的坚定承诺，特别是禁止使用武力及和平解决争端的原则。作为和平区，拉美地区的历史经验表明，任何争端都无法通过单边行动得到合法解决。</p>\n<p>　　哥伦比亚总统府办公厅主任安吉&middot;罗德里格斯3日晚宣布，哥方要求5日召开联合国安全理事会紧急会议，并提议召开美洲国家组织常设理事会特别会议，以应对委内瑞拉局势变化对地区稳定造成的影响。罗德里格斯说，哥伦比亚已在与委接壤的边境地区启动医疗系统黄色警戒。哥政府下令加强人道主义措施，并在哥委边境部署3万名士兵，宣布武装部队进入一级战备状态，以应对可能升级的局势。</p>\n<p>　　&ldquo;美方行动构成危险的先例，违背国际法准则&rdquo;</p>\n<p>　　联合国秘书长古特雷斯通过发言人发表声明，对委内瑞拉局势升级深表震惊，指出&ldquo;美方行动构成危险的先例，违背国际法准则&rdquo;。他呼吁各方开展包容性对话，尊重人权和法治。应委内瑞拉正式请求，联合国安理会定于美国东部时间1月5日上午10点举行紧急会议，就此次军事行动进行讨论。联合国人权事务高级专员蒂尔克敦促各方保持克制，强调&ldquo;保护委内瑞拉人民是首要任务&rdquo;。</p>\n<p>　　非洲联盟3日发布声明说，非盟正在关注委内瑞拉局势，对该国近期发生的事件深感忧虑。委内瑞拉内部问题唯有通过委内瑞拉人民的政治对话才能得到妥善解决，并呼吁各方尊重国际法。</p>\n<p>　　俄罗斯外交部3日在社交媒体发布消息说，俄外长拉夫罗夫当天与白俄罗斯外长雷任科夫通电话，双方一致强烈谴责美国侵略委内瑞拉，强调必须立即释放马杜罗及其夫人，让他们返回祖国。两国外长还说，必须尽快创造条件，通过符合国际法的对话解决委内瑞拉问题。</p>\n<p>　　据朝中社4日报道，朝鲜外务省发言人当天表示，委内瑞拉当前局势的严重性完全是由美国动用强权造成的，这将使本已脆弱的地区局势更加不稳定。这名发言人称，该事件再次清楚地证明了美国的野蛮行径。</p>\n<p>　　法国外长巴罗3日在社交媒体发文表示，强行控制委内瑞拉总统马杜罗的军事行动违背了国际法赖以建立的不使用武力原则。巴罗强调，任何持久的政治解决方案都不能由外部强加，只有主权人民有权决定他们的未来。法国重申遵循《联合国宪章》，该宪章将继续指导各国在任何时刻、任何地方的国际行动。</p>\n<p>　　挪威外交大臣艾德3日接受挪威广播公司采访时表示，国际法具有普遍性和约束力，美国对委内瑞拉的干预&ldquo;不符合国际法&rdquo;。丹麦外交大臣拉斯穆森3日接受丹麦广播公司采访时说，必须维护对国际规则的尊重，国际法应得到遵守。他强调国际社会应&ldquo;回到缓和局势、推动对话的轨道上来&rdquo;。</p>\n<p>&nbsp;</p>\n<p><span id=\"paper_num\">　　《 人民日报 》（ 2026年01月05日 15 版）</span></p>', '2026-01-05 10:39:08', NULL, '新闻/时政/国外', '#新闻 #热点', 1, '/api/images/6.png', 2, '');
INSERT INTO `t_article` VALUES (62, '咖啡', '李四', '<p><img src=\"/api/images/bfdcc7bc-581f-4c24-b5fd-3434b533b00c.jpg\" width=\"643\" height=\"482\"></p>\n<p>埃塞的豆子</p>', '2026-01-05 11:06:22', NULL, '生活', '#美饮 #咖啡 #coffee #Hong Kong', 1, '/api/images/e136d48c-4711-41ee-ab1e-67a2d89cf05a.jpg', 2, '香港');
INSERT INTO `t_article` VALUES (65, '2025.01.06工作总结', '王德发', '<p>1.新增排行榜排位变化（需打磨升级）。</p>\n<p>1.修复头像上传预览：修正了后端静态资源映射路径，解决上传头像后无法立即加载的问题。&nbsp;</p>\n<p>2.修复用户名修改失效：修正了前端表单数据绑定错误（name -&gt; username），确保修改能正确提交。</p>\n<p>3.修复时间显示精度：修正了注册时间只显示日期不显示时间的问题。</p>\n<p>4. 增强账户安全性：修改邮箱现在必须获取并输入邮件验证码，流程与注册一致。</p>\n<p>5. 升级&ldquo;我的评论&rdquo;：个人中心现在可以查看您的回复记录，并清晰展示是&ldquo;评论了文章《X》&rdquo;还是&ldquo;回复了用户 @Y&rdquo;。</p>\n<p>6. 优化评论交互：在评论区点击&ldquo;回复&rdquo;按钮时，输入框会自动弹出并获取光标，无需手动点击。</p>', '2026-01-07 04:26:20', NULL, '学习', '#总结 #学习', 1, '/api/images/6.png', 8, '东莞理工学院');

-- ----------------------------
-- Table structure for t_article_like
-- ----------------------------
DROP TABLE IF EXISTS `t_article_like`;
CREATE TABLE `t_article_like`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `article_id` int NOT NULL,
  `created` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_article`(`user_id` ASC, `article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article_like
-- ----------------------------
INSERT INTO `t_article_like` VALUES (5, 6, 54, '2026-01-04 22:36:19');
INSERT INTO `t_article_like` VALUES (10, 1, 41, '2026-01-04 23:10:04');
INSERT INTO `t_article_like` VALUES (11, 6, 55, '2026-01-04 23:38:27');
INSERT INTO `t_article_like` VALUES (14, 5, 41, '2026-01-04 23:44:05');
INSERT INTO `t_article_like` VALUES (15, 3, 41, '2026-01-04 23:44:22');
INSERT INTO `t_article_like` VALUES (16, 7, 41, '2026-01-04 23:47:29');
INSERT INTO `t_article_like` VALUES (17, 4, 41, '2026-01-04 23:48:32');
INSERT INTO `t_article_like` VALUES (18, 2, 41, '2026-01-05 07:16:59');
INSERT INTO `t_article_like` VALUES (20, 10, 41, '2026-01-05 13:47:05');
INSERT INTO `t_article_like` VALUES (21, 6, 62, '2026-01-07 03:05:46');
INSERT INTO `t_article_like` VALUES (22, 9, 62, '2026-01-07 03:05:56');
INSERT INTO `t_article_like` VALUES (23, 9, 55, '2026-01-07 03:06:06');
INSERT INTO `t_article_like` VALUES (24, 8, 55, '2026-01-07 03:06:28');
INSERT INTO `t_article_like` VALUES (25, 8, 62, '2026-01-07 03:07:40');
INSERT INTO `t_article_like` VALUES (26, 2, 55, '2026-01-07 03:07:52');

-- ----------------------------
-- Table structure for t_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_article_tag`;
CREATE TABLE `t_article_tag`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_article_tag`(`article_id` ASC, `tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article_tag
-- ----------------------------
INSERT INTO `t_article_tag` VALUES (1, 1, 8);
INSERT INTO `t_article_tag` VALUES (2, 1, 9);
INSERT INTO `t_article_tag` VALUES (3, 1, 10);
INSERT INTO `t_article_tag` VALUES (4, 2, 8);
INSERT INTO `t_article_tag` VALUES (5, 2, 11);
INSERT INTO `t_article_tag` VALUES (6, 2, 12);
INSERT INTO `t_article_tag` VALUES (7, 3, 8);
INSERT INTO `t_article_tag` VALUES (9, 3, 12);
INSERT INTO `t_article_tag` VALUES (8, 3, 13);
INSERT INTO `t_article_tag` VALUES (10, 4, 8);
INSERT INTO `t_article_tag` VALUES (12, 4, 12);
INSERT INTO `t_article_tag` VALUES (11, 4, 14);
INSERT INTO `t_article_tag` VALUES (13, 5, 8);
INSERT INTO `t_article_tag` VALUES (16, 5, 12);
INSERT INTO `t_article_tag` VALUES (14, 5, 15);
INSERT INTO `t_article_tag` VALUES (15, 5, 16);
INSERT INTO `t_article_tag` VALUES (17, 6, 8);
INSERT INTO `t_article_tag` VALUES (18, 6, 17);
INSERT INTO `t_article_tag` VALUES (19, 7, 18);
INSERT INTO `t_article_tag` VALUES (20, 7, 19);
INSERT INTO `t_article_tag` VALUES (21, 8, 20);
INSERT INTO `t_article_tag` VALUES (22, 8, 21);
INSERT INTO `t_article_tag` VALUES (23, 9, 22);
INSERT INTO `t_article_tag` VALUES (24, 9, 23);
INSERT INTO `t_article_tag` VALUES (25, 9, 24);
INSERT INTO `t_article_tag` VALUES (26, 10, 23);
INSERT INTO `t_article_tag` VALUES (27, 10, 25);
INSERT INTO `t_article_tag` VALUES (28, 11, 23);
INSERT INTO `t_article_tag` VALUES (29, 11, 26);
INSERT INTO `t_article_tag` VALUES (30, 12, 27);
INSERT INTO `t_article_tag` VALUES (31, 35, 9);
INSERT INTO `t_article_tag` VALUES (32, 35, 28);
INSERT INTO `t_article_tag` VALUES (33, 36, 29);
INSERT INTO `t_article_tag` VALUES (34, 36, 30);
INSERT INTO `t_article_tag` VALUES (35, 38, 29);
INSERT INTO `t_article_tag` VALUES (36, 40, 31);
INSERT INTO `t_article_tag` VALUES (37, 40, 32);
INSERT INTO `t_article_tag` VALUES (38, 41, 33);
INSERT INTO `t_article_tag` VALUES (39, 41, 34);
INSERT INTO `t_article_tag` VALUES (40, 41, 35);
INSERT INTO `t_article_tag` VALUES (41, 41, 36);
INSERT INTO `t_article_tag` VALUES (43, 41, 38);
INSERT INTO `t_article_tag` VALUES (44, 41, 39);
INSERT INTO `t_article_tag` VALUES (45, 42, 31);
INSERT INTO `t_article_tag` VALUES (46, 42, 32);
INSERT INTO `t_article_tag` VALUES (47, 55, 40);
INSERT INTO `t_article_tag` VALUES (48, 56, 2);
INSERT INTO `t_article_tag` VALUES (49, 56, 3);
INSERT INTO `t_article_tag` VALUES (62, 62, 33);
INSERT INTO `t_article_tag` VALUES (59, 62, 34);
INSERT INTO `t_article_tag` VALUES (60, 62, 35);
INSERT INTO `t_article_tag` VALUES (61, 62, 36);
INSERT INTO `t_article_tag` VALUES (74, 65, 40);
INSERT INTO `t_article_tag` VALUES (73, 65, 46);

-- ----------------------------
-- Table structure for t_authority
-- ----------------------------
DROP TABLE IF EXISTS `t_authority`;
CREATE TABLE `t_authority`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `authority` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_authority
-- ----------------------------
INSERT INTO `t_authority` VALUES (1, 'ROLE_admin');
INSERT INTO `t_authority` VALUES (2, 'ROLE_common');

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT 0 COMMENT '父分类ID，0代表根节点',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `sort` int NULL DEFAULT 0 COMMENT '排序（越小越前）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '无限级文章分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (1, 0, '技术', 1);
INSERT INTO `t_category` VALUES (2, 0, '生活', 2);
INSERT INTO `t_category` VALUES (3, 1, '后端', 2);
INSERT INTO `t_category` VALUES (4, 1, '前端', 3);
INSERT INTO `t_category` VALUES (5, 3, 'Java', 1);
INSERT INTO `t_category` VALUES (6, 1, 'SpringBoot', 1);
INSERT INTO `t_category` VALUES (7, 4, 'Vue3', 1);
INSERT INTO `t_category` VALUES (8, 0, '学习', 3);
INSERT INTO `t_category` VALUES (9, 2, '美食', 0);
INSERT INTO `t_category` VALUES (10, 0, '新闻', 0);
INSERT INTO `t_category` VALUES (11, 10, '时政', 0);
INSERT INTO `t_category` VALUES (12, 11, '国外', 0);
INSERT INTO `t_category` VALUES (13, 1, 'Python', 0);
INSERT INTO `t_category` VALUES (14, 1, 'Python', 0);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `article_id` int NOT NULL COMMENT '关联的文章id',
  `created` datetime NOT NULL COMMENT '评论时间',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论用户登录的ip地址',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'approved' COMMENT '评论状态',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论用户用户名',
  `user_id` int NULL DEFAULT NULL COMMENT '评论者ID',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP属地',
  `likes` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 121 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 12, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很不错，不过这文章排版不太好看啊', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (2, 11, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很不错的原理分析，受用了！', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (3, 10, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '关于Docker虚拟容器的讲解挺好的额，学习中', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (9, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '非常不错，赞一个！', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (10, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '博主，这资料怎么弄的？有相关资源和教材推荐吗？', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (11, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很详细，感谢...', 'approved', '东方不败', 3, NULL, 0);
INSERT INTO `t_comment` VALUES (12, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很全，努力学习中...', 'approved', '东方不败', 3, NULL, 0);
INSERT INTO `t_comment` VALUES (13, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '好东西，先收藏起来，哈哈', 'approved', 'tom', 4, NULL, 0);
INSERT INTO `t_comment` VALUES (14, 8, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', 'very good blog', 'approved', 'tom', 4, NULL, 0);
INSERT INTO `t_comment` VALUES (30, 19, '2025-12-16 00:00:00', NULL, '123', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (31, 21, '2025-12-17 00:00:00', NULL, '123', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (32, 21, '2025-12-17 00:00:00', NULL, '123123123123123123123', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (33, 19, '2025-12-17 02:54:25', NULL, '你好你', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (34, 22, '2025-12-17 03:04:07', NULL, '我是尼克狐尼克', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (35, 21, '2025-12-17 03:24:52', NULL, '你好', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (36, 21, '2025-12-17 03:25:06', NULL, 'bh1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (37, 21, '2025-12-17 03:25:07', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (39, 21, '2025-12-17 03:25:09', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (40, 21, '2025-12-17 03:25:10', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (41, 21, '2025-12-17 03:25:10', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (42, 21, '2025-12-17 03:25:16', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (43, 21, '2025-12-17 03:25:17', NULL, '2', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (44, 23, '2025-12-17 21:19:58', NULL, '???为什么这个文章显示不出来\n', 'approved', 'zzt', 6, NULL, 0);
INSERT INTO `t_comment` VALUES (45, 24, '2025-12-18 04:43:01', NULL, '已修复', 'approved', 'zzt', 6, NULL, 3);
INSERT INTO `t_comment` VALUES (46, 29, '2026-01-02 04:14:11', NULL, '新年快乐', 'approved', 'zzt', 6, NULL, 0);
INSERT INTO `t_comment` VALUES (47, 29, '2026-01-02 04:14:34', NULL, '新年快乐', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (48, 1, '2026-01-02 15:30:17', NULL, '真的能高薪吗', 'approved', 'zzt', 6, NULL, 0);
INSERT INTO `t_comment` VALUES (49, 30, '2026-01-02 17:43:52', '192.168.1.100', '看看ip\n', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (50, 30, '2026-01-02 18:08:01', '192.168.1.100', '再看看', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (51, 30, '2026-01-02 19:59:14', '192.168.1.100', '再看看看', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (52, 30, '2026-01-02 20:02:01', '192.168.1.100', '本地局域网是什么鬼', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (53, 30, '2026-01-03 00:29:10', '142.249.36.58', '看看ip', 'approved', '123', 5, '未知星球', 0);
INSERT INTO `t_comment` VALUES (54, 30, '2026-01-03 00:33:06', '142.249.36.58', '现在是哪里', 'approved', '123', 5, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (55, 30, '2026-01-03 00:34:51', '141.11.146.76', '再看一眼', 'approved', '123', 5, '法国|0|0|法国电信', 0);
INSERT INTO `t_comment` VALUES (56, 30, '2026-01-03 06:24:09', '192.168.1.100', '再看看', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (57, 30, '2026-01-03 06:24:22', '45.147.201.215', '再看看\n', 'approved', '123', 5, '荷兰|0|0|0', 0);
INSERT INTO `t_comment` VALUES (58, 30, '2026-01-03 06:41:07', '192.168.1.100', '有点小bug\n', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (59, 30, '2026-01-03 18:35:01', '192.168.1.100', '1234', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (60, 30, '2026-01-04 00:43:57', '142.249.36.185', '看一下ip', 'approved', '123', 5, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (61, 26, '2026-01-04 01:07:07', '142.249.36.185', '来水一下', 'approved', '123', 5, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (62, 30, '2026-01-04 01:44:57', '142.249.36.185', '你好', 'approved', '123', 5, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (63, 30, '2026-01-04 01:45:52', '142.249.36.185', '你好', 'approved', '123', 5, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (64, 30, '2026-01-04 01:46:20', '142.249.36.185', '你好', 'approved', '123', 5, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (65, 30, '2026-01-04 01:51:20', '192.168.1.100', '你好', 'approved', '123', 5, '本地局域网', 1);
INSERT INTO `t_comment` VALUES (66, 30, '2026-01-04 01:51:32', '192.168.1.100', '你好', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (67, 30, '2026-01-04 01:54:53', '192.168.1.100', '你好', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (68, 30, '2026-01-04 01:55:05', '192.168.1.100', '数据库为空???\n', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (69, 16, '2026-01-04 02:01:36', '142.249.36.185', '我来评论一下你的文章', 'approved', 'zzt', 6, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (70, 34, '2026-01-04 02:25:39', '192.168.1.100', '我来评论一下你', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (71, 34, '2026-01-04 02:33:50', '192.168.1.100', '我来评论一下我自己的文章', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (72, 33, '2026-01-04 02:34:12', '192.168.1.100', '我来评论一下admin的文章', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (73, 32, '2026-01-04 02:34:31', '192.168.1.100', '我再来评论一下admin的文章', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (74, 31, '2026-01-04 02:34:47', '192.168.1.100', '我继续评论admin的文章\n', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (75, 34, '2026-01-04 02:35:14', '192.168.1.100', '我来评论一下123的文章', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (76, 36, '2026-01-04 03:23:24', '192.168.1.100', '修复成功啦', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (77, 30, '2026-01-04 08:24:58', '192.168.1.105', '我现在在哪里', 'approved', '李四', 2, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (78, 37, '2026-01-04 08:30:52', '192.168.1.102', '我来回复一下', 'approved', '李四', 2, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (79, 37, '2026-01-04 08:32:03', '192.168.1.102', '我也来回复一下', 'approved', 'tom', 4, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (80, 40, '2026-01-04 09:13:37', '192.168.1.102', '看来是可以！', 'approved', '东方不败', 3, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (82, 41, '2026-01-04 10:30:50', '192.168.1.102', '看起来好好喝', 'approved', '东方不败', 3, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (83, 41, '2026-01-04 10:32:40', '192.168.1.102', '李四的号有问题', 'approved', 'tom', 4, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (85, 41, '2026-01-04 10:35:46', '192.168.1.102', '怎么评论不了了?。。。', 'approved', 'tom', 4, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (86, 41, '2026-01-04 10:35:56', '192.168.1.102', '香港物价就是这样的，一杯要你七八十刀', 'approved', '东方不败', 3, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (87, 41, '2026-01-04 11:19:08', '192.168.1.102', '亚米亚米', 'approved', '李四', 2, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (88, 41, '2026-01-04 11:30:11', '192.168.1.102', '香港真是个好地方啊', 'approved', '东方不败', 3, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (89, 40, '2026-01-04 11:34:26', '192.168.1.102', '评论一下就消失了...', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (90, 23, '2026-01-04 11:34:51', '192.168.1.102', '奇怪', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (92, 41, '2026-01-04 11:50:13', '192.168.1.102', '好是好，但是太贵了！', 'approved', '尊贵的iPhone17ProMax用户', 7, '本地局域网', 1);
INSERT INTO `t_comment` VALUES (93, 41, '2026-01-04 13:39:36', '192.168.1.102', '怎么有小概率评论框会显示。。。', 'approved', 'tom', 4, '本地局域网', 3);
INSERT INTO `t_comment` VALUES (94, 1, '2026-01-04 19:52:36', '192.168.1.102', '我来刷一下楼数', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (95, 1, '2026-01-04 19:52:43', '192.168.1.102', '我来刷一下楼数1', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (96, 1, '2026-01-04 19:52:46', '192.168.1.102', '我来刷一下楼数2', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (97, 1, '2026-01-04 19:52:50', '192.168.1.102', '我来刷一下楼数3', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (98, 1, '2026-01-04 19:52:55', '192.168.1.102', '我来刷一下楼数4', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (99, 1, '2026-01-04 19:53:01', '192.168.1.102', '我来刷一下楼数5', 'approved', '123', 5, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (100, 41, '2026-01-04 22:19:50', '192.168.1.102', '呃呃', 'approved', 'zzt', 6, '本地局域网', 3);
INSERT INTO `t_comment` VALUES (101, 55, '2026-01-04 23:38:33', '192.168.1.102', '辛苦你了', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (102, 55, '2026-01-04 23:39:01', '192.168.1.102', '哇塞,向博主学习', 'approved', '李四', 2, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (103, 41, '2026-01-04 23:44:38', '192.168.1.102', '这个帖子最近很火哦', 'approved', '东方不败', 3, '本地局域网', 1);
INSERT INTO `t_comment` VALUES (104, 41, '2026-01-04 23:48:48', '192.168.1.102', '图片比例尺有点奇怪', 'approved', 'tom', 4, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (105, 62, '2026-01-05 13:22:19', '192.168.1.102', '个人感觉有点发酵,不过还行', 'approved', 'zzt', 6, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (106, 62, '2026-01-05 13:39:18', '120.235.59.235', '我评论一下', 'approved', 'zzt', 6, '中国|广东省|东莞市|移动', 0);
INSERT INTO `t_comment` VALUES (107, 30, '2026-01-05 13:46:55', '192.168.1.102', '现在我应该是本地局域网', 'approved', '我不是马神', 10, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (108, 30, '2026-01-05 13:48:31', '120.235.59.235', '我现在应该是东莞', 'approved', '王德志', NULL, '中国|广东省|东莞市|移动', 0);
INSERT INTO `t_comment` VALUES (109, 30, '2026-01-05 13:48:47', '141.11.146.76', '我现在应该是香港', 'approved', '王德志', NULL, '法国|0|0|法国电信', 0);
INSERT INTO `t_comment` VALUES (110, 30, '2026-01-05 13:49:44', '141.11.146.76', '奇怪', 'approved', '王德志', NULL, '法国|0|0|法国电信', 0);
INSERT INTO `t_comment` VALUES (111, 30, '2026-01-05 13:49:55', '141.11.146.76', '现在在哪', 'approved', '王德志', NULL, '法国|0|0|法国电信', 0);
INSERT INTO `t_comment` VALUES (112, 59, '2026-01-05 22:49:17', '192.168.1.102', '神人特朗普', 'approved', '我不是马神', 10, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (113, 59, '2026-01-05 23:01:01', '192.168.1.102', '美帝国主义之心人人诛之', 'approved', 'tom', 4, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (114, 65, '2026-01-07 16:12:13', '111.55.210.235', '123', 'approved', '王德发', 8, '中国|0|0|移动', 0);
INSERT INTO `t_comment` VALUES (115, 65, '2026-01-07 16:25:47', '141.11.146.77', '为什么评论看不到头像', 'approved', '王德发', 8, '法国|0|0|法国电信', 0);
INSERT INTO `t_comment` VALUES (116, 65, '2026-01-07 21:23:56', '192.168.1.101', '我来发布一个新评论', 'approved', '王德发', 8, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (117, 65, '2026-01-07 21:28:21', '192.168.1.101', '123', 'approved', '王德发', 8, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (118, 65, '2026-01-07 21:30:20', '192.168.1.101', '123', 'approved', '王德发', 8, '本地局域网', 0);

-- ----------------------------
-- Table structure for t_comment_like
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_like`;
CREATE TABLE `t_comment_like`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `comment_id` int NOT NULL,
  `created` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_comment`(`user_id` ASC, `comment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment_like
-- ----------------------------
INSERT INTO `t_comment_like` VALUES (12, 6, 100, '2026-01-04 22:38:58');
INSERT INTO `t_comment_like` VALUES (13, 6, 93, '2026-01-04 22:39:00');
INSERT INTO `t_comment_like` VALUES (15, 6, 45, '2026-01-04 22:39:04');
INSERT INTO `t_comment_like` VALUES (17, 1, 45, '2026-01-04 22:49:11');
INSERT INTO `t_comment_like` VALUES (19, 1, 93, '2026-01-04 22:49:16');
INSERT INTO `t_comment_like` VALUES (20, 1, 100, '2026-01-04 23:10:07');
INSERT INTO `t_comment_like` VALUES (21, 3, 103, '2026-01-04 23:44:40');
INSERT INTO `t_comment_like` VALUES (22, 3, 100, '2026-01-04 23:44:41');
INSERT INTO `t_comment_like` VALUES (24, 4, 65, '2026-01-05 07:38:08');

-- ----------------------------
-- Table structure for t_notification
-- ----------------------------
DROP TABLE IF EXISTS `t_notification`;
CREATE TABLE `t_notification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发送者用户名(缓存)',
  `receiver_id` int NOT NULL COMMENT '接收者ID',
  `article_id` int NULL DEFAULT NULL COMMENT '关联文章ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息内容摘要',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型: COMMENT(评论), REPLY(回复), SYSTEM(系统)',
  `is_read` tinyint(1) NULL DEFAULT 0 COMMENT '0:未读, 1:已读',
  `created` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `comment_id` int NULL DEFAULT NULL COMMENT '关联的评论ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_notification
-- ----------------------------
INSERT INTO `t_notification` VALUES (1, 5, '123', 6, 30, '评论了你的文章: 你好', 'COMMENT', 1, '2026-01-04 01:54:53', NULL);
INSERT INTO `t_notification` VALUES (2, 5, '123', 6, 30, '评论了你的文章: 数据库为空???\n', 'COMMENT', 1, '2026-01-04 01:55:05', NULL);
INSERT INTO `t_notification` VALUES (3, 6, 'zzt', 5, 16, '评论了你的文章: 我来评论一下你的文章', 'COMMENT', 1, '2026-01-04 02:01:36', NULL);
INSERT INTO `t_notification` VALUES (4, 6, 'zzt', 5, 34, '评论了你的文章: 我来评论一下你', 'COMMENT', 1, '2026-01-04 02:25:39', NULL);
INSERT INTO `t_notification` VALUES (5, 5, '123', 1, 33, '评论了你的文章: 我来评论一下admin的文章', 'COMMENT', 1, '2026-01-04 02:34:12', NULL);
INSERT INTO `t_notification` VALUES (6, 5, '123', 1, 32, '评论了你的文章: 我再来评论一下admin的文章', 'COMMENT', 1, '2026-01-04 02:34:31', NULL);
INSERT INTO `t_notification` VALUES (7, 5, '123', 1, 31, '评论了你的文章: 我继续评论admin的文章\n', 'COMMENT', 1, '2026-01-04 02:34:47', NULL);
INSERT INTO `t_notification` VALUES (8, 6, 'zzt', 5, 34, '评论了你的文章: 我来评论一下123的文章', 'COMMENT', 1, '2026-01-04 02:35:14', NULL);
INSERT INTO `t_notification` VALUES (9, 6, 'zzt', 1, 36, '评论了你的文章: 修复成功啦', 'COMMENT', 1, '2026-01-04 03:23:24', NULL);
INSERT INTO `t_notification` VALUES (10, 2, '李四', 6, 30, '评论了你的文章: 我现在在哪里', 'COMMENT', 1, '2026-01-04 08:24:58', NULL);
INSERT INTO `t_notification` VALUES (11, 4, 'tom', 2, 37, '评论了你的文章: 我也来回复一下', 'COMMENT', 1, '2026-01-04 08:32:03', NULL);
INSERT INTO `t_notification` VALUES (12, 3, '东方不败', 6, 40, '评论了你的文章: 看来是可以！', 'COMMENT', 1, '2026-01-04 09:13:37', NULL);
INSERT INTO `t_notification` VALUES (13, 3, '东方不败', 6, 41, '评论了你的文章: 看起来好好喝', 'COMMENT', 1, '2026-01-04 10:30:50', NULL);
INSERT INTO `t_notification` VALUES (14, 4, 'tom', 6, 41, '评论了你的文章: 李四的号有问题', 'COMMENT', 1, '2026-01-04 10:32:40', NULL);
INSERT INTO `t_notification` VALUES (15, 4, 'tom', 2, NULL, '回复了你的评论: 你好', 'REPLY', 1, '2026-01-04 10:32:46', NULL);
INSERT INTO `t_notification` VALUES (16, 3, '东方不败', 6, 41, '评论了你的文章: 🇭🇰物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:34:29', NULL);
INSERT INTO `t_notification` VALUES (17, 3, '东方不败', 6, 41, '评论了你的文章: 🇭🇰物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:34:49', NULL);
INSERT INTO `t_notification` VALUES (18, 3, '东方不败', 6, 41, '评论了你的文章: 🇭🇰物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:35:12', NULL);
INSERT INTO `t_notification` VALUES (19, 4, 'tom', 6, 41, '评论了你的文章: 怎么评论不了了?。。。', 'COMMENT', 1, '2026-01-04 10:35:46', NULL);
INSERT INTO `t_notification` VALUES (20, 3, '东方不败', 6, 41, '评论了你的文章: 香港物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:35:56', NULL);
INSERT INTO `t_notification` VALUES (21, 2, '李四', 6, 41, '评论了你的文章: 亚米亚米', 'COMMENT', 1, '2026-01-04 11:19:08', NULL);
INSERT INTO `t_notification` VALUES (22, 4, 'tom', 2, NULL, '回复了你的评论: 怎么这样的', 'REPLY', 1, '2026-01-04 11:29:13', NULL);
INSERT INTO `t_notification` VALUES (23, 3, '东方不败', 6, 41, '评论了你的文章: 香港真是个好地方啊', 'COMMENT', 1, '2026-01-04 11:30:11', NULL);
INSERT INTO `t_notification` VALUES (24, 6, 'zzt', 2, 23, '评论了你的文章: 奇怪', 'COMMENT', 1, '2026-01-04 11:34:51', NULL);
INSERT INTO `t_notification` VALUES (25, 6, 'zzt', 1, NULL, '回复了你的评论: 回复一下你', 'REPLY', 1, '2026-01-04 11:35:01', NULL);
INSERT INTO `t_notification` VALUES (26, 7, '尊贵的iPhone17ProMax用户', 6, 41, '评论了你的文章: 好是好，但是太贵了！', 'COMMENT', 1, '2026-01-04 11:50:13', NULL);
INSERT INTO `t_notification` VALUES (27, 4, 'tom', 1, 41, '评论了你的文章: 怎么🈶小概率评论框会显示。。。', 'COMMENT', 1, '2026-01-04 13:39:27', NULL);
INSERT INTO `t_notification` VALUES (28, 4, 'tom', 1, 41, '评论了你的文章: 怎么有小概率评论框会显示。。。', 'COMMENT', 1, '2026-01-04 13:39:36', NULL);
INSERT INTO `t_notification` VALUES (29, 5, '123', 3, 1, '评论了你的文章: 我来刷一下楼数', 'COMMENT', 1, '2026-01-04 19:52:36', NULL);
INSERT INTO `t_notification` VALUES (30, 5, '123', 3, 1, '评论了你的文章: 我来刷一下楼数1', 'COMMENT', 1, '2026-01-04 19:52:43', NULL);
INSERT INTO `t_notification` VALUES (31, 5, '123', 3, 1, '评论了你的文章: 我来刷一下楼数2', 'COMMENT', 1, '2026-01-04 19:52:46', NULL);
INSERT INTO `t_notification` VALUES (32, 5, '123', 3, 1, '评论了你的文章: 我来刷一下楼数3', 'COMMENT', 1, '2026-01-04 19:52:50', NULL);
INSERT INTO `t_notification` VALUES (33, 5, '123', 3, 1, '评论了你的文章: 我来刷一下楼数4', 'COMMENT', 1, '2026-01-04 19:52:55', NULL);
INSERT INTO `t_notification` VALUES (34, 5, '123', 3, 1, '评论了你的文章: 我来刷一下楼数5', 'COMMENT', 1, '2026-01-04 19:53:01', NULL);
INSERT INTO `t_notification` VALUES (35, 6, 'zzt', 1, 41, '评论了你的文章: 呃呃', 'COMMENT', 1, '2026-01-04 22:19:50', NULL);
INSERT INTO `t_notification` VALUES (36, 2, '李四', 6, 55, '评论了你的文章: 哇塞,向博主学习', 'COMMENT', 1, '2026-01-04 23:39:01', NULL);
INSERT INTO `t_notification` VALUES (37, 3, '东方不败', 1, 41, '评论了你的文章: 这个帖子最近很火哦', 'COMMENT', 1, '2026-01-04 23:44:38', NULL);
INSERT INTO `t_notification` VALUES (38, 4, 'tom', 1, 41, '评论了你的文章: 图片比例尺有点奇怪', 'COMMENT', 1, '2026-01-04 23:48:48', NULL);
INSERT INTO `t_notification` VALUES (39, 6, 'zzt', 2, 62, '评论了你的文章: 个人感觉有点发酵,不过还行', 'COMMENT', 0, '2026-01-05 13:22:19', NULL);
INSERT INTO `t_notification` VALUES (40, 6, 'zzt', 2, 62, '评论了你的文章: 我评论一下', 'COMMENT', 0, '2026-01-05 13:39:18', NULL);
INSERT INTO `t_notification` VALUES (41, 10, '我不是马神', 6, 30, '评论了你的文章: 现在我应该是本地局域网', 'COMMENT', 1, '2026-01-05 13:46:55', NULL);
INSERT INTO `t_notification` VALUES (42, 8, '王德志', 6, 30, '评论了你的文章: 我现在应该是东莞', 'COMMENT', 1, '2026-01-05 13:48:31', NULL);
INSERT INTO `t_notification` VALUES (43, 8, '王德志', 6, 30, '评论了你的文章: 我现在应该是香港', 'COMMENT', 1, '2026-01-05 13:48:47', NULL);
INSERT INTO `t_notification` VALUES (44, 8, '王德志', 6, 30, '评论了你的文章: 奇怪', 'COMMENT', 1, '2026-01-05 13:49:44', NULL);
INSERT INTO `t_notification` VALUES (45, 8, '王德志', 6, 30, '评论了你的文章: 现在在哪', 'COMMENT', 1, '2026-01-05 13:49:55', NULL);
INSERT INTO `t_notification` VALUES (46, 10, '我不是马神', 2, 59, '评论了你的文章: 神人特朗普', 'COMMENT', 0, '2026-01-05 22:49:17', NULL);
INSERT INTO `t_notification` VALUES (47, 4, 'tom', 2, 59, '评论了你的文章: 美帝国主义之心人人诛之', 'COMMENT', 0, '2026-01-05 23:01:01', NULL);
INSERT INTO `t_notification` VALUES (48, 8, '王德志', 2, 62, '回复了你的评论: 456', 'REPLY', 0, '2026-01-07 03:21:34', 106);

-- ----------------------------
-- Table structure for t_op_log
-- ----------------------------
DROP TABLE IF EXISTS `t_op_log`;
CREATE TABLE `t_op_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型：BROWSE(浏览), COMMENT(评论), LOGIN(登录)',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作描述，如文章标题',
  `target_id` int NULL DEFAULT NULL COMMENT '关联的目标ID，如文章ID',
  `created` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 543 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户操作日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_op_log
-- ----------------------------
INSERT INTO `t_op_log` VALUES (1, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 18:04:48');
INSERT INTO `t_op_log` VALUES (2, 1, 'BROWSE', '浏览了文章: we', 19, '2025-12-17 18:04:51');
INSERT INTO `t_op_log` VALUES (3, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 18:05:13');
INSERT INTO `t_op_log` VALUES (4, 1, 'BROWSE', '浏览了文章: we', 19, '2025-12-17 18:05:24');
INSERT INTO `t_op_log` VALUES (5, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 18:05:27');
INSERT INTO `t_op_log` VALUES (6, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:15:35');
INSERT INTO `t_op_log` VALUES (7, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:15:40');
INSERT INTO `t_op_log` VALUES (8, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 21:15:42');
INSERT INTO `t_op_log` VALUES (9, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:15:46');
INSERT INTO `t_op_log` VALUES (10, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:19:35');
INSERT INTO `t_op_log` VALUES (11, 6, 'COMMENT', '评论了文章: ???为什么这个文章显示不出来\n', 23, '2025-12-17 21:19:58');
INSERT INTO `t_op_log` VALUES (12, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:20:12');
INSERT INTO `t_op_log` VALUES (13, 6, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 22:43:04');
INSERT INTO `t_op_log` VALUES (14, 6, 'BROWSE', '浏览了文章: 2202020202', 18, '2025-12-17 22:43:08');
INSERT INTO `t_op_log` VALUES (15, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 22:43:10');
INSERT INTO `t_op_log` VALUES (16, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 22:45:04');
INSERT INTO `t_op_log` VALUES (17, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 22:45:08');
INSERT INTO `t_op_log` VALUES (18, 1, 'BROWSE', '浏览了文章: 未知文章', 24, '2025-12-17 22:46:37');
INSERT INTO `t_op_log` VALUES (19, 1, 'BROWSE', '浏览了文章: 未知文章', 24, '2025-12-17 22:47:33');
INSERT INTO `t_op_log` VALUES (20, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 23:49:05');
INSERT INTO `t_op_log` VALUES (21, 1, 'BROWSE', '浏览了文章: 未知文章', 25, '2025-12-17 23:52:18');
INSERT INTO `t_op_log` VALUES (22, 1, 'BROWSE', '浏览了文章: 2121', 25, '2025-12-17 23:52:50');
INSERT INTO `t_op_log` VALUES (23, 1, 'BROWSE', '浏览了文章: 未知文章', 26, '2025-12-17 23:55:13');
INSERT INTO `t_op_log` VALUES (24, 1, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 00:15:29');
INSERT INTO `t_op_log` VALUES (25, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 00:16:03');
INSERT INTO `t_op_log` VALUES (26, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 00:16:13');
INSERT INTO `t_op_log` VALUES (27, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 00:18:51');
INSERT INTO `t_op_log` VALUES (28, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 04:02:41');
INSERT INTO `t_op_log` VALUES (29, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2025-12-18 04:02:50');
INSERT INTO `t_op_log` VALUES (30, 6, 'BROWSE', '浏览了文章: 虚拟化容器技术——Docker运行机制介绍', 9, '2025-12-18 04:02:55');
INSERT INTO `t_op_log` VALUES (31, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 04:03:00');
INSERT INTO `t_op_log` VALUES (32, 6, 'BROWSE', '浏览了文章: we', 19, '2025-12-18 04:03:12');
INSERT INTO `t_op_log` VALUES (33, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 04:42:55');
INSERT INTO `t_op_log` VALUES (34, 6, 'COMMENT', '评论了文章: 已修复', 24, '2025-12-18 04:43:01');
INSERT INTO `t_op_log` VALUES (35, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 04:45:22');
INSERT INTO `t_op_log` VALUES (36, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 04:48:51');
INSERT INTO `t_op_log` VALUES (37, 6, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 04:48:52');
INSERT INTO `t_op_log` VALUES (38, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 04:48:55');
INSERT INTO `t_op_log` VALUES (39, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 05:40:11');
INSERT INTO `t_op_log` VALUES (40, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 05:40:25');
INSERT INTO `t_op_log` VALUES (41, 1, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 05:40:27');
INSERT INTO `t_op_log` VALUES (42, 1, 'BROWSE', '浏览了文章: 2121', 25, '2025-12-18 05:40:28');
INSERT INTO `t_op_log` VALUES (43, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 05:40:30');
INSERT INTO `t_op_log` VALUES (44, 1, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 06:06:13');
INSERT INTO `t_op_log` VALUES (45, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:06:17');
INSERT INTO `t_op_log` VALUES (46, 1, 'BROWSE', '浏览了文章: 2121', 25, '2025-12-18 06:06:24');
INSERT INTO `t_op_log` VALUES (47, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:06:33');
INSERT INTO `t_op_log` VALUES (48, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:06:49');
INSERT INTO `t_op_log` VALUES (49, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:25');
INSERT INTO `t_op_log` VALUES (50, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:29');
INSERT INTO `t_op_log` VALUES (51, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:37');
INSERT INTO `t_op_log` VALUES (52, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:40');
INSERT INTO `t_op_log` VALUES (53, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:42');
INSERT INTO `t_op_log` VALUES (54, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:41:38');
INSERT INTO `t_op_log` VALUES (55, 1, 'BROWSE', '浏览了文章: 测试', 26, '2025-12-18 06:41:42');
INSERT INTO `t_op_log` VALUES (56, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:41:45');
INSERT INTO `t_op_log` VALUES (57, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:41:47');
INSERT INTO `t_op_log` VALUES (58, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:44:13');
INSERT INTO `t_op_log` VALUES (59, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:47:33');
INSERT INTO `t_op_log` VALUES (60, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:47:37');
INSERT INTO `t_op_log` VALUES (61, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:47:40');
INSERT INTO `t_op_log` VALUES (62, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:51:35');
INSERT INTO `t_op_log` VALUES (63, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:51:37');
INSERT INTO `t_op_log` VALUES (64, 1, 'BROWSE', '浏览了文章: we', 19, '2025-12-18 06:51:39');
INSERT INTO `t_op_log` VALUES (65, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-18 06:51:41');
INSERT INTO `t_op_log` VALUES (66, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:57:25');
INSERT INTO `t_op_log` VALUES (67, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:57:32');
INSERT INTO `t_op_log` VALUES (68, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:57:49');
INSERT INTO `t_op_log` VALUES (69, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:02:52');
INSERT INTO `t_op_log` VALUES (70, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 07:06:54');
INSERT INTO `t_op_log` VALUES (71, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:06:59');
INSERT INTO `t_op_log` VALUES (72, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:07:50');
INSERT INTO `t_op_log` VALUES (73, 6, 'BROWSE', '浏览了文章: we', 19, '2025-12-18 07:08:01');
INSERT INTO `t_op_log` VALUES (74, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:08:56');
INSERT INTO `t_op_log` VALUES (75, 6, 'BROWSE', '浏览了文章: 123', 27, '2026-01-02 03:54:57');
INSERT INTO `t_op_log` VALUES (76, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 03:55:09');
INSERT INTO `t_op_log` VALUES (77, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 03:55:19');
INSERT INTO `t_op_log` VALUES (78, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 04:07:34');
INSERT INTO `t_op_log` VALUES (79, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 04:14:07');
INSERT INTO `t_op_log` VALUES (80, 6, 'COMMENT', '评论了文章: 新年快乐', 29, '2026-01-02 04:14:11');
INSERT INTO `t_op_log` VALUES (81, 5, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 04:14:24');
INSERT INTO `t_op_log` VALUES (82, 5, 'COMMENT', '评论了文章: 新年快乐', 29, '2026-01-02 04:14:34');
INSERT INTO `t_op_log` VALUES (83, 6, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2026-01-02 04:21:59');
INSERT INTO `t_op_log` VALUES (84, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 04:22:55');
INSERT INTO `t_op_log` VALUES (85, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 04:41:40');
INSERT INTO `t_op_log` VALUES (86, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 15:29:33');
INSERT INTO `t_op_log` VALUES (87, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-02 15:29:48');
INSERT INTO `t_op_log` VALUES (88, 6, 'COMMENT', '评论了文章: 真的能高薪吗', 1, '2026-01-02 15:30:17');
INSERT INTO `t_op_log` VALUES (89, 6, 'BROWSE', '浏览了文章: Spring Boot 2 权威发布', 12, '2026-01-02 16:33:13');
INSERT INTO `t_op_log` VALUES (90, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-02 16:34:24');
INSERT INTO `t_op_log` VALUES (91, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 16:40:08');
INSERT INTO `t_op_log` VALUES (92, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 17:42:48');
INSERT INTO `t_op_log` VALUES (93, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-02 17:43:45');
INSERT INTO `t_op_log` VALUES (94, 6, 'COMMENT', '评论了文章: 看看ip\n', 30, '2026-01-02 17:43:52');
INSERT INTO `t_op_log` VALUES (95, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-02 18:07:57');
INSERT INTO `t_op_log` VALUES (96, 6, 'COMMENT', '评论了文章: 再看看', 30, '2026-01-02 18:08:01');
INSERT INTO `t_op_log` VALUES (97, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-02 19:56:36');
INSERT INTO `t_op_log` VALUES (98, 5, 'COMMENT', '评论了文章: 再看看看', 30, '2026-01-02 19:59:14');
INSERT INTO `t_op_log` VALUES (99, 5, 'COMMENT', '评论了文章: 本地局域网是什么鬼', 30, '2026-01-02 20:02:01');
INSERT INTO `t_op_log` VALUES (100, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:29:04');
INSERT INTO `t_op_log` VALUES (101, 5, 'COMMENT', '评论了文章: 看看ip', 30, '2026-01-03 00:29:10');
INSERT INTO `t_op_log` VALUES (102, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:31:42');
INSERT INTO `t_op_log` VALUES (103, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:32:56');
INSERT INTO `t_op_log` VALUES (104, 5, 'COMMENT', '评论了文章: 现在是哪里', 30, '2026-01-03 00:33:06');
INSERT INTO `t_op_log` VALUES (105, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:34:23');
INSERT INTO `t_op_log` VALUES (106, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:34:44');
INSERT INTO `t_op_log` VALUES (107, 5, 'COMMENT', '评论了文章: 再看一眼', 30, '2026-01-03 00:34:51');
INSERT INTO `t_op_log` VALUES (108, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:41:58');
INSERT INTO `t_op_log` VALUES (109, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:18:58');
INSERT INTO `t_op_log` VALUES (110, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:20:34');
INSERT INTO `t_op_log` VALUES (111, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:21:05');
INSERT INTO `t_op_log` VALUES (112, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:23:54');
INSERT INTO `t_op_log` VALUES (113, 6, 'COMMENT', '评论了文章: 再看看', 30, '2026-01-03 06:24:09');
INSERT INTO `t_op_log` VALUES (114, 5, 'COMMENT', '评论了文章: 再看看\n', 30, '2026-01-03 06:24:22');
INSERT INTO `t_op_log` VALUES (115, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:26:38');
INSERT INTO `t_op_log` VALUES (116, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:28:49');
INSERT INTO `t_op_log` VALUES (117, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:40:45');
INSERT INTO `t_op_log` VALUES (118, 6, 'COMMENT', '评论了文章: 有点小bug\n', 30, '2026-01-03 06:41:07');
INSERT INTO `t_op_log` VALUES (119, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 07:00:32');
INSERT INTO `t_op_log` VALUES (120, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 07:00:43');
INSERT INTO `t_op_log` VALUES (121, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 07:01:30');
INSERT INTO `t_op_log` VALUES (122, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 18:34:42');
INSERT INTO `t_op_log` VALUES (123, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 18:34:58');
INSERT INTO `t_op_log` VALUES (124, 5, 'COMMENT', '评论了文章: 1234', 30, '2026-01-03 18:35:01');
INSERT INTO `t_op_log` VALUES (125, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 18:35:14');
INSERT INTO `t_op_log` VALUES (126, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 00:43:28');
INSERT INTO `t_op_log` VALUES (127, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 00:43:50');
INSERT INTO `t_op_log` VALUES (128, 5, 'COMMENT', '评论了文章: 看一下ip', 30, '2026-01-04 00:43:57');
INSERT INTO `t_op_log` VALUES (129, 5, 'BROWSE', '浏览了文章: 测试', 26, '2026-01-04 01:06:55');
INSERT INTO `t_op_log` VALUES (130, 5, 'COMMENT', '评论了文章: 来水一下', 26, '2026-01-04 01:07:07');
INSERT INTO `t_op_log` VALUES (131, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:25:47');
INSERT INTO `t_op_log` VALUES (132, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:44:43');
INSERT INTO `t_op_log` VALUES (133, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:44:51');
INSERT INTO `t_op_log` VALUES (134, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:44:57');
INSERT INTO `t_op_log` VALUES (135, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:45:52');
INSERT INTO `t_op_log` VALUES (136, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:46:20');
INSERT INTO `t_op_log` VALUES (137, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:49:10');
INSERT INTO `t_op_log` VALUES (138, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:49:26');
INSERT INTO `t_op_log` VALUES (139, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:50:56');
INSERT INTO `t_op_log` VALUES (140, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:51:16');
INSERT INTO `t_op_log` VALUES (141, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:51:20');
INSERT INTO `t_op_log` VALUES (142, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:51:32');
INSERT INTO `t_op_log` VALUES (143, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:54:53');
INSERT INTO `t_op_log` VALUES (144, 5, 'COMMENT', '评论了文章: 数据库为空???\n', 30, '2026-01-04 01:55:05');
INSERT INTO `t_op_log` VALUES (145, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:58:33');
INSERT INTO `t_op_log` VALUES (146, 6, 'BROWSE', '浏览了文章: 12234', 16, '2026-01-04 02:01:20');
INSERT INTO `t_op_log` VALUES (147, 6, 'COMMENT', '评论了文章: 我来评论一下你的文章', 16, '2026-01-04 02:01:36');
INSERT INTO `t_op_log` VALUES (148, 5, 'BROWSE', '浏览了文章: 我再再来发布一篇看看', 33, '2026-01-04 02:23:12');
INSERT INTO `t_op_log` VALUES (149, 1, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:25:17');
INSERT INTO `t_op_log` VALUES (150, 6, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:25:25');
INSERT INTO `t_op_log` VALUES (151, 6, 'COMMENT', '评论了文章: 我来评论一下你', 34, '2026-01-04 02:25:39');
INSERT INTO `t_op_log` VALUES (152, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:32:53');
INSERT INTO `t_op_log` VALUES (153, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:32:58');
INSERT INTO `t_op_log` VALUES (154, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:33:34');
INSERT INTO `t_op_log` VALUES (155, 5, 'COMMENT', '评论了文章: 我来评论一下我自己的文章', 34, '2026-01-04 02:33:50');
INSERT INTO `t_op_log` VALUES (156, 5, 'BROWSE', '浏览了文章: 我再再来发布一篇看看', 33, '2026-01-04 02:34:00');
INSERT INTO `t_op_log` VALUES (157, 5, 'COMMENT', '评论了文章: 我来评论一下admin的文章', 33, '2026-01-04 02:34:12');
INSERT INTO `t_op_log` VALUES (158, 5, 'BROWSE', '浏览了文章: 我再来发布一篇看看', 32, '2026-01-04 02:34:19');
INSERT INTO `t_op_log` VALUES (159, 5, 'COMMENT', '评论了文章: 我再来评论一下admin的文章', 32, '2026-01-04 02:34:31');
INSERT INTO `t_op_log` VALUES (160, 5, 'BROWSE', '浏览了文章: 123', 31, '2026-01-04 02:34:37');
INSERT INTO `t_op_log` VALUES (161, 5, 'COMMENT', '评论了文章: 我继续评论admin的文章\n', 31, '2026-01-04 02:34:47');
INSERT INTO `t_op_log` VALUES (162, 6, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:35:02');
INSERT INTO `t_op_log` VALUES (163, 6, 'COMMENT', '评论了文章: 我来评论一下123的文章', 34, '2026-01-04 02:35:14');
INSERT INTO `t_op_log` VALUES (164, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:35:24');
INSERT INTO `t_op_log` VALUES (165, 6, 'BROWSE', '浏览了文章: 我现在要来验证一下分类标签功能是否能正常使用', 35, '2026-01-04 02:52:54');
INSERT INTO `t_op_log` VALUES (166, 1, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 03:15:30');
INSERT INTO `t_op_log` VALUES (167, 1, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 03:23:07');
INSERT INTO `t_op_log` VALUES (168, 6, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 03:23:16');
INSERT INTO `t_op_log` VALUES (169, 6, 'COMMENT', '评论了文章: 修复成功啦', 36, '2026-01-04 03:23:24');
INSERT INTO `t_op_log` VALUES (170, 6, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 07:55:07');
INSERT INTO `t_op_log` VALUES (171, 6, 'BROWSE', '浏览了文章: Docker常用客户端指令介绍', 10, '2026-01-04 07:57:46');
INSERT INTO `t_op_log` VALUES (172, 2, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 08:24:51');
INSERT INTO `t_op_log` VALUES (173, 2, 'COMMENT', '评论了文章: 我现在在哪里', 30, '2026-01-04 08:24:58');
INSERT INTO `t_op_log` VALUES (174, 2, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 08:30:43');
INSERT INTO `t_op_log` VALUES (175, 2, 'COMMENT', '评论了文章: 我来回复一下', 37, '2026-01-04 08:30:52');
INSERT INTO `t_op_log` VALUES (176, 2, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 08:31:03');
INSERT INTO `t_op_log` VALUES (177, 4, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 08:31:56');
INSERT INTO `t_op_log` VALUES (178, 4, 'COMMENT', '评论了文章: 我也来回复一下', 37, '2026-01-04 08:32:03');
INSERT INTO `t_op_log` VALUES (179, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 08:49:31');
INSERT INTO `t_op_log` VALUES (180, 3, 'BROWSE', '浏览了文章: JDK 8——聚合操作', 8, '2026-01-04 09:06:38');
INSERT INTO `t_op_log` VALUES (181, 3, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:13:16');
INSERT INTO `t_op_log` VALUES (182, 3, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:13:22');
INSERT INTO `t_op_log` VALUES (183, 3, 'COMMENT', '评论了文章: 看来是可以！', 40, '2026-01-04 09:13:37');
INSERT INTO `t_op_log` VALUES (184, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:34:41');
INSERT INTO `t_op_log` VALUES (185, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:12');
INSERT INTO `t_op_log` VALUES (186, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:15');
INSERT INTO `t_op_log` VALUES (187, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:18');
INSERT INTO `t_op_log` VALUES (188, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:35');
INSERT INTO `t_op_log` VALUES (189, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:39');
INSERT INTO `t_op_log` VALUES (190, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:53:51');
INSERT INTO `t_op_log` VALUES (191, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:55');
INSERT INTO `t_op_log` VALUES (192, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:05');
INSERT INTO `t_op_log` VALUES (193, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:22');
INSERT INTO `t_op_log` VALUES (194, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:29');
INSERT INTO `t_op_log` VALUES (195, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:35');
INSERT INTO `t_op_log` VALUES (196, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:53');
INSERT INTO `t_op_log` VALUES (197, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:55:06');
INSERT INTO `t_op_log` VALUES (198, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:57:03');
INSERT INTO `t_op_log` VALUES (199, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:09:52');
INSERT INTO `t_op_log` VALUES (200, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:09:56');
INSERT INTO `t_op_log` VALUES (201, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:11:17');
INSERT INTO `t_op_log` VALUES (202, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 10:11:37');
INSERT INTO `t_op_log` VALUES (203, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 10:11:40');
INSERT INTO `t_op_log` VALUES (204, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:12:14');
INSERT INTO `t_op_log` VALUES (205, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:15:08');
INSERT INTO `t_op_log` VALUES (206, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:15:50');
INSERT INTO `t_op_log` VALUES (207, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:15:57');
INSERT INTO `t_op_log` VALUES (208, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:16:06');
INSERT INTO `t_op_log` VALUES (209, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:17:06');
INSERT INTO `t_op_log` VALUES (210, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:19:41');
INSERT INTO `t_op_log` VALUES (211, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 10:19:47');
INSERT INTO `t_op_log` VALUES (212, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:20:21');
INSERT INTO `t_op_log` VALUES (213, 6, 'COMMENT', '评论了文章: 我来', 20, '2026-01-04 10:20:27');
INSERT INTO `t_op_log` VALUES (214, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 10:20:36');
INSERT INTO `t_op_log` VALUES (215, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:20:41');
INSERT INTO `t_op_log` VALUES (216, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:20:58');
INSERT INTO `t_op_log` VALUES (217, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:36');
INSERT INTO `t_op_log` VALUES (218, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:39');
INSERT INTO `t_op_log` VALUES (219, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:50');
INSERT INTO `t_op_log` VALUES (220, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:53');
INSERT INTO `t_op_log` VALUES (221, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:24:20');
INSERT INTO `t_op_log` VALUES (222, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:24:43');
INSERT INTO `t_op_log` VALUES (223, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:29:58');
INSERT INTO `t_op_log` VALUES (224, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:30:13');
INSERT INTO `t_op_log` VALUES (225, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:30:18');
INSERT INTO `t_op_log` VALUES (226, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:30:39');
INSERT INTO `t_op_log` VALUES (227, 3, 'COMMENT', '评论了文章: 看起来好好喝', 41, '2026-01-04 10:30:50');
INSERT INTO `t_op_log` VALUES (228, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:31:05');
INSERT INTO `t_op_log` VALUES (229, 2, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 10:31:13');
INSERT INTO `t_op_log` VALUES (230, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:31:27');
INSERT INTO `t_op_log` VALUES (231, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:32:26');
INSERT INTO `t_op_log` VALUES (232, 4, 'COMMENT', '评论了文章: 李四的号有问题', 41, '2026-01-04 10:32:40');
INSERT INTO `t_op_log` VALUES (233, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 10:33:20');
INSERT INTO `t_op_log` VALUES (234, 6, 'COMMENT', '评论了文章: ???这个文章怎么可以做到没有标题没有内...', 39, '2026-01-04 10:33:39');
INSERT INTO `t_op_log` VALUES (235, 6, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 10:33:49');
INSERT INTO `t_op_log` VALUES (236, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:34:44');
INSERT INTO `t_op_log` VALUES (237, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:35:14');
INSERT INTO `t_op_log` VALUES (238, 4, 'COMMENT', '评论了文章: 怎么评论不了了?。。。', 41, '2026-01-04 10:35:46');
INSERT INTO `t_op_log` VALUES (239, 3, 'COMMENT', '评论了文章: 香港物价就是这样的，一杯要你七八十刀', 41, '2026-01-04 10:35:56');
INSERT INTO `t_op_log` VALUES (240, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:36:19');
INSERT INTO `t_op_log` VALUES (241, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 10:40:28');
INSERT INTO `t_op_log` VALUES (242, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:48:55');
INSERT INTO `t_op_log` VALUES (243, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:49:12');
INSERT INTO `t_op_log` VALUES (244, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 10:49:14');
INSERT INTO `t_op_log` VALUES (245, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:49:25');
INSERT INTO `t_op_log` VALUES (246, 6, 'BROWSE', '浏览了文章: 2018新版前端与移动开发学习线路图', 3, '2026-01-04 10:49:48');
INSERT INTO `t_op_log` VALUES (247, 6, 'BROWSE', '浏览了文章: 123', 31, '2026-01-04 10:49:52');
INSERT INTO `t_op_log` VALUES (248, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:11:04');
INSERT INTO `t_op_log` VALUES (249, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:11:44');
INSERT INTO `t_op_log` VALUES (250, 6, 'BROWSE', '浏览了文章: 2018新版前端与移动开发学习线路图', 3, '2026-01-04 11:11:46');
INSERT INTO `t_op_log` VALUES (251, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:12:12');
INSERT INTO `t_op_log` VALUES (252, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:16:23');
INSERT INTO `t_op_log` VALUES (253, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 11:16:25');
INSERT INTO `t_op_log` VALUES (254, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 11:16:29');
INSERT INTO `t_op_log` VALUES (255, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:17:18');
INSERT INTO `t_op_log` VALUES (256, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:18:50');
INSERT INTO `t_op_log` VALUES (257, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:19:00');
INSERT INTO `t_op_log` VALUES (258, 2, 'COMMENT', '评论了文章: 亚米亚米', 41, '2026-01-04 11:19:08');
INSERT INTO `t_op_log` VALUES (259, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:27:50');
INSERT INTO `t_op_log` VALUES (260, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:28:10');
INSERT INTO `t_op_log` VALUES (261, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:28:20');
INSERT INTO `t_op_log` VALUES (262, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:29:58');
INSERT INTO `t_op_log` VALUES (263, 3, 'COMMENT', '评论了文章: 香港真是个好地方啊', 41, '2026-01-04 11:30:11');
INSERT INTO `t_op_log` VALUES (264, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:33:23');
INSERT INTO `t_op_log` VALUES (265, 2, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:33:35');
INSERT INTO `t_op_log` VALUES (266, 2, 'BROWSE', '浏览了文章: 2121', 25, '2026-01-04 11:33:41');
INSERT INTO `t_op_log` VALUES (267, 2, 'BROWSE', '浏览了文章: 测试', 26, '2026-01-04 11:33:45');
INSERT INTO `t_op_log` VALUES (268, 2, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:33:51');
INSERT INTO `t_op_log` VALUES (269, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:33:54');
INSERT INTO `t_op_log` VALUES (270, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 11:34:11');
INSERT INTO `t_op_log` VALUES (271, 6, 'COMMENT', '评论了文章: 评论一下就消失了...', 40, '2026-01-04 11:34:26');
INSERT INTO `t_op_log` VALUES (272, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:34:28');
INSERT INTO `t_op_log` VALUES (273, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 11:34:31');
INSERT INTO `t_op_log` VALUES (274, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-04 11:34:37');
INSERT INTO `t_op_log` VALUES (275, 6, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:34:42');
INSERT INTO `t_op_log` VALUES (276, 6, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:34:44');
INSERT INTO `t_op_log` VALUES (277, 6, 'COMMENT', '评论了文章: 奇怪', 23, '2026-01-04 11:34:51');
INSERT INTO `t_op_log` VALUES (278, 6, 'BROWSE', '浏览了文章: 测试', 26, '2026-01-04 11:35:09');
INSERT INTO `t_op_log` VALUES (279, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-04 11:35:33');
INSERT INTO `t_op_log` VALUES (280, 6, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 11:35:42');
INSERT INTO `t_op_log` VALUES (281, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 11:35:46');
INSERT INTO `t_op_log` VALUES (282, 6, 'BROWSE', '浏览了文章: 我现在要来验证一下分类标签功能是否能正常使用', 35, '2026-01-04 11:35:52');
INSERT INTO `t_op_log` VALUES (283, 6, 'BROWSE', '浏览了文章: 123', 27, '2026-01-04 11:35:56');
INSERT INTO `t_op_log` VALUES (284, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 11:36:00');
INSERT INTO `t_op_log` VALUES (285, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 11:36:06');
INSERT INTO `t_op_log` VALUES (286, 6, 'BROWSE', '浏览了文章: 123', 31, '2026-01-04 11:36:20');
INSERT INTO `t_op_log` VALUES (287, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:36:27');
INSERT INTO `t_op_log` VALUES (288, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:36:29');
INSERT INTO `t_op_log` VALUES (289, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:36:37');
INSERT INTO `t_op_log` VALUES (290, 6, 'COMMENT', '评论了文章: ???', 39, '2026-01-04 11:36:42');
INSERT INTO `t_op_log` VALUES (291, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:36:44');
INSERT INTO `t_op_log` VALUES (292, 6, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:36:49');
INSERT INTO `t_op_log` VALUES (293, 6, 'BROWSE', '浏览了文章: 2121', 25, '2026-01-04 11:36:53');
INSERT INTO `t_op_log` VALUES (294, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:41:59');
INSERT INTO `t_op_log` VALUES (295, 7, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:49:38');
INSERT INTO `t_op_log` VALUES (296, 7, 'COMMENT', '评论了文章: 好是好，但是太贵了！', 41, '2026-01-04 11:50:13');
INSERT INTO `t_op_log` VALUES (297, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 12:43:20');
INSERT INTO `t_op_log` VALUES (298, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 12:43:38');
INSERT INTO `t_op_log` VALUES (299, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:00:14');
INSERT INTO `t_op_log` VALUES (300, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:07:44');
INSERT INTO `t_op_log` VALUES (301, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:10:54');
INSERT INTO `t_op_log` VALUES (302, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:11:14');
INSERT INTO `t_op_log` VALUES (303, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:11:44');
INSERT INTO `t_op_log` VALUES (304, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:18:48');
INSERT INTO `t_op_log` VALUES (305, 1, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 13:19:20');
INSERT INTO `t_op_log` VALUES (306, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:19:42');
INSERT INTO `t_op_log` VALUES (307, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:22:22');
INSERT INTO `t_op_log` VALUES (308, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:25:58');
INSERT INTO `t_op_log` VALUES (309, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:26:02');
INSERT INTO `t_op_log` VALUES (310, 4, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:37:42');
INSERT INTO `t_op_log` VALUES (311, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:37:47');
INSERT INTO `t_op_log` VALUES (312, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:37:57');
INSERT INTO `t_op_log` VALUES (313, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:38:49');
INSERT INTO `t_op_log` VALUES (314, 4, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:39:02');
INSERT INTO `t_op_log` VALUES (315, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:39:04');
INSERT INTO `t_op_log` VALUES (316, 4, 'COMMENT', '评论了文章: 怎么有小概率评论框会显示。。。', 41, '2026-01-04 13:39:36');
INSERT INTO `t_op_log` VALUES (317, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:39:39');
INSERT INTO `t_op_log` VALUES (318, 4, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 13:39:47');
INSERT INTO `t_op_log` VALUES (319, 4, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:39:50');
INSERT INTO `t_op_log` VALUES (320, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:39:53');
INSERT INTO `t_op_log` VALUES (321, 2, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 18:24:09');
INSERT INTO `t_op_log` VALUES (322, 2, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 18:30:29');
INSERT INTO `t_op_log` VALUES (323, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 18:30:38');
INSERT INTO `t_op_log` VALUES (324, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 18:56:29');
INSERT INTO `t_op_log` VALUES (325, 1, 'BROWSE', '浏览了文章: 我现在要来验证一下分类标签功能是否能正常使用', 35, '2026-01-04 19:05:33');
INSERT INTO `t_op_log` VALUES (326, 1, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 19:10:11');
INSERT INTO `t_op_log` VALUES (327, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:12:51');
INSERT INTO `t_op_log` VALUES (328, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:16:14');
INSERT INTO `t_op_log` VALUES (329, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:36:27');
INSERT INTO `t_op_log` VALUES (330, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:36:32');
INSERT INTO `t_op_log` VALUES (331, 1, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 19:37:47');
INSERT INTO `t_op_log` VALUES (332, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:37:57');
INSERT INTO `t_op_log` VALUES (333, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:38:54');
INSERT INTO `t_op_log` VALUES (334, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:39:12');
INSERT INTO `t_op_log` VALUES (335, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:39:21');
INSERT INTO `t_op_log` VALUES (336, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:39:28');
INSERT INTO `t_op_log` VALUES (337, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:39:52');
INSERT INTO `t_op_log` VALUES (338, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:39:56');
INSERT INTO `t_op_log` VALUES (339, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:40:03');
INSERT INTO `t_op_log` VALUES (340, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:40:29');
INSERT INTO `t_op_log` VALUES (341, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:42:49');
INSERT INTO `t_op_log` VALUES (342, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:42:52');
INSERT INTO `t_op_log` VALUES (343, 5, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:44:03');
INSERT INTO `t_op_log` VALUES (344, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:44:06');
INSERT INTO `t_op_log` VALUES (345, 5, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:45:27');
INSERT INTO `t_op_log` VALUES (346, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:45:32');
INSERT INTO `t_op_log` VALUES (347, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:47:30');
INSERT INTO `t_op_log` VALUES (348, 5, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 19:48:33');
INSERT INTO `t_op_log` VALUES (349, 5, 'COMMENT', '评论了文章: 我来刷一下楼数', 1, '2026-01-04 19:52:36');
INSERT INTO `t_op_log` VALUES (350, 5, 'COMMENT', '评论了文章: 我来刷一下楼数1', 1, '2026-01-04 19:52:43');
INSERT INTO `t_op_log` VALUES (351, 5, 'COMMENT', '评论了文章: 我来刷一下楼数2', 1, '2026-01-04 19:52:46');
INSERT INTO `t_op_log` VALUES (352, 5, 'COMMENT', '评论了文章: 我来刷一下楼数3', 1, '2026-01-04 19:52:50');
INSERT INTO `t_op_log` VALUES (353, 5, 'COMMENT', '评论了文章: 我来刷一下楼数4', 1, '2026-01-04 19:52:55');
INSERT INTO `t_op_log` VALUES (354, 5, 'COMMENT', '评论了文章: 我来刷一下楼数5', 1, '2026-01-04 19:53:01');
INSERT INTO `t_op_log` VALUES (355, 5, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 19:53:06');
INSERT INTO `t_op_log` VALUES (356, 5, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 19:54:00');
INSERT INTO `t_op_log` VALUES (357, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 19:54:59');
INSERT INTO `t_op_log` VALUES (358, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 19:55:02');
INSERT INTO `t_op_log` VALUES (359, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 20:39:19');
INSERT INTO `t_op_log` VALUES (360, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:39:45');
INSERT INTO `t_op_log` VALUES (361, 1, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 20:39:53');
INSERT INTO `t_op_log` VALUES (362, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:42:46');
INSERT INTO `t_op_log` VALUES (363, 5, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:42:54');
INSERT INTO `t_op_log` VALUES (364, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:44:32');
INSERT INTO `t_op_log` VALUES (365, 1, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:44:34');
INSERT INTO `t_op_log` VALUES (366, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:44:51');
INSERT INTO `t_op_log` VALUES (367, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 20:44:58');
INSERT INTO `t_op_log` VALUES (368, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 20:45:18');
INSERT INTO `t_op_log` VALUES (369, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 20:45:54');
INSERT INTO `t_op_log` VALUES (370, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 20:46:55');
INSERT INTO `t_op_log` VALUES (371, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 20:46:59');
INSERT INTO `t_op_log` VALUES (372, 1, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 21:44:29');
INSERT INTO `t_op_log` VALUES (373, 6, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 21:44:36');
INSERT INTO `t_op_log` VALUES (374, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 21:44:47');
INSERT INTO `t_op_log` VALUES (375, 6, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 22:07:33');
INSERT INTO `t_op_log` VALUES (376, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:07:37');
INSERT INTO `t_op_log` VALUES (377, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:18:44');
INSERT INTO `t_op_log` VALUES (378, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:19:09');
INSERT INTO `t_op_log` VALUES (379, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:19:44');
INSERT INTO `t_op_log` VALUES (380, 6, 'COMMENT', '评论了文章: 呃呃', 41, '2026-01-04 22:19:50');
INSERT INTO `t_op_log` VALUES (381, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:19');
INSERT INTO `t_op_log` VALUES (382, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:24');
INSERT INTO `t_op_log` VALUES (383, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:28');
INSERT INTO `t_op_log` VALUES (384, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:33');
INSERT INTO `t_op_log` VALUES (385, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:36');
INSERT INTO `t_op_log` VALUES (386, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:39');
INSERT INTO `t_op_log` VALUES (387, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:48');
INSERT INTO `t_op_log` VALUES (388, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:23:50');
INSERT INTO `t_op_log` VALUES (389, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:23:56');
INSERT INTO `t_op_log` VALUES (390, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 22:24:57');
INSERT INTO `t_op_log` VALUES (391, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:25:02');
INSERT INTO `t_op_log` VALUES (392, 6, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 22:36:18');
INSERT INTO `t_op_log` VALUES (393, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:37:41');
INSERT INTO `t_op_log` VALUES (394, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:38:57');
INSERT INTO `t_op_log` VALUES (395, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:39:20');
INSERT INTO `t_op_log` VALUES (396, 1, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 22:48:43');
INSERT INTO `t_op_log` VALUES (397, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:48:51');
INSERT INTO `t_op_log` VALUES (398, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 22:49:03');
INSERT INTO `t_op_log` VALUES (399, 1, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 22:53:46');
INSERT INTO `t_op_log` VALUES (400, 1, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 22:54:40');
INSERT INTO `t_op_log` VALUES (401, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:08:03');
INSERT INTO `t_op_log` VALUES (402, 1, 'BROWSE', '浏览了文章: 听说有草稿箱功能?', 54, '2026-01-04 23:08:19');
INSERT INTO `t_op_log` VALUES (403, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:10:02');
INSERT INTO `t_op_log` VALUES (404, 6, 'BROWSE', '浏览了文章: JDK 8——聚合操作', 8, '2026-01-04 23:19:59');
INSERT INTO `t_op_log` VALUES (405, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:30:09');
INSERT INTO `t_op_log` VALUES (406, 6, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-04 23:38:26');
INSERT INTO `t_op_log` VALUES (407, 6, 'COMMENT', '评论了文章: 辛苦你了', 55, '2026-01-04 23:38:33');
INSERT INTO `t_op_log` VALUES (408, 2, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-04 23:38:49');
INSERT INTO `t_op_log` VALUES (409, 2, 'COMMENT', '评论了文章: 哇塞,向博主学习', 55, '2026-01-04 23:39:01');
INSERT INTO `t_op_log` VALUES (410, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:17');
INSERT INTO `t_op_log` VALUES (411, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:22');
INSERT INTO `t_op_log` VALUES (412, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:39');
INSERT INTO `t_op_log` VALUES (413, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:40');
INSERT INTO `t_op_log` VALUES (414, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:41');
INSERT INTO `t_op_log` VALUES (415, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:41');
INSERT INTO `t_op_log` VALUES (416, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:42');
INSERT INTO `t_op_log` VALUES (417, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:42');
INSERT INTO `t_op_log` VALUES (418, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:47');
INSERT INTO `t_op_log` VALUES (419, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:39:48');
INSERT INTO `t_op_log` VALUES (420, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:40:42');
INSERT INTO `t_op_log` VALUES (421, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:41:43');
INSERT INTO `t_op_log` VALUES (422, 5, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:44:03');
INSERT INTO `t_op_log` VALUES (423, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:44:21');
INSERT INTO `t_op_log` VALUES (424, 3, 'COMMENT', '评论了文章: 这个帖子最近很火哦', 41, '2026-01-04 23:44:38');
INSERT INTO `t_op_log` VALUES (425, 3, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 23:45:08');
INSERT INTO `t_op_log` VALUES (426, 7, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:47:28');
INSERT INTO `t_op_log` VALUES (427, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 23:48:31');
INSERT INTO `t_op_log` VALUES (428, 4, 'COMMENT', '评论了文章: 图片比例尺有点奇怪', 41, '2026-01-04 23:48:48');
INSERT INTO `t_op_log` VALUES (429, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 07:16:56');
INSERT INTO `t_op_log` VALUES (430, 2, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-05 07:17:42');
INSERT INTO `t_op_log` VALUES (431, 4, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-05 07:35:46');
INSERT INTO `t_op_log` VALUES (432, 4, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-05 07:36:54');
INSERT INTO `t_op_log` VALUES (433, 4, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-05 07:37:06');
INSERT INTO `t_op_log` VALUES (434, 4, 'BROWSE', '浏览了文章: 文章必须加标题...', 39, '2026-01-05 07:37:15');
INSERT INTO `t_op_log` VALUES (435, 4, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-05 07:37:19');
INSERT INTO `t_op_log` VALUES (436, 4, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-05 07:37:33');
INSERT INTO `t_op_log` VALUES (437, 4, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-05 07:38:13');
INSERT INTO `t_op_log` VALUES (438, 2, 'BROWSE', '浏览了文章: 美方披露抓获马杜罗更多细节', 56, '2026-01-05 07:49:44');
INSERT INTO `t_op_log` VALUES (440, 2, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-05 08:17:54');
INSERT INTO `t_op_log` VALUES (441, 2, 'BROWSE', '浏览了文章: 国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', 59, '2026-01-05 10:39:15');
INSERT INTO `t_op_log` VALUES (442, 2, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-05 11:07:38');
INSERT INTO `t_op_log` VALUES (443, 2, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-05 11:07:53');
INSERT INTO `t_op_log` VALUES (448, 8, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 12:56:34');
INSERT INTO `t_op_log` VALUES (449, 8, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 12:57:13');
INSERT INTO `t_op_log` VALUES (452, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-05 13:22:05');
INSERT INTO `t_op_log` VALUES (453, 6, 'COMMENT', '评论了文章: 个人感觉有点发酵,不过还行', 62, '2026-01-05 13:22:19');
INSERT INTO `t_op_log` VALUES (454, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-05 13:23:03');
INSERT INTO `t_op_log` VALUES (455, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 13:34:49');
INSERT INTO `t_op_log` VALUES (456, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-05 13:39:02');
INSERT INTO `t_op_log` VALUES (457, 6, 'COMMENT', '评论了文章: 我评论一下', 62, '2026-01-05 13:39:18');
INSERT INTO `t_op_log` VALUES (458, 10, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-05 13:46:45');
INSERT INTO `t_op_log` VALUES (459, 10, 'COMMENT', '评论了文章: 现在我应该是本地局域网', 30, '2026-01-05 13:46:55');
INSERT INTO `t_op_log` VALUES (460, 10, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 13:47:04');
INSERT INTO `t_op_log` VALUES (461, 8, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-05 13:48:18');
INSERT INTO `t_op_log` VALUES (462, 8, 'COMMENT', '评论了文章: 我现在应该是东莞', 30, '2026-01-05 13:48:31');
INSERT INTO `t_op_log` VALUES (463, 8, 'COMMENT', '评论了文章: 我现在应该是香港', 30, '2026-01-05 13:48:47');
INSERT INTO `t_op_log` VALUES (464, 8, 'COMMENT', '评论了文章: 奇怪', 30, '2026-01-05 13:49:44');
INSERT INTO `t_op_log` VALUES (465, 8, 'COMMENT', '评论了文章: 现在在哪', 30, '2026-01-05 13:49:55');
INSERT INTO `t_op_log` VALUES (466, 8, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 13:52:16');
INSERT INTO `t_op_log` VALUES (467, 8, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 13:54:08');
INSERT INTO `t_op_log` VALUES (468, 10, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 13:54:15');
INSERT INTO `t_op_log` VALUES (469, 10, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-05 13:54:20');
INSERT INTO `t_op_log` VALUES (470, 8, 'BROWSE', '浏览了文章: 美方披露抓获马杜罗更多细节', 56, '2026-01-05 13:54:44');
INSERT INTO `t_op_log` VALUES (471, 8, 'BROWSE', '浏览了文章: 国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', 59, '2026-01-05 13:54:59');
INSERT INTO `t_op_log` VALUES (472, 10, 'BROWSE', '浏览了文章: 国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', 59, '2026-01-05 22:49:06');
INSERT INTO `t_op_log` VALUES (473, 10, 'COMMENT', '评论了文章: 神人特朗普', 59, '2026-01-05 22:49:17');
INSERT INTO `t_op_log` VALUES (474, 10, 'BROWSE', '浏览了文章: 国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', 59, '2026-01-05 22:57:23');
INSERT INTO `t_op_log` VALUES (475, 4, 'BROWSE', '浏览了文章: 国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', 59, '2026-01-05 23:00:34');
INSERT INTO `t_op_log` VALUES (476, 4, 'COMMENT', '评论了文章: 美帝国主义之心人人诛之', 59, '2026-01-05 23:01:01');
INSERT INTO `t_op_log` VALUES (477, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-06 12:47:25');
INSERT INTO `t_op_log` VALUES (478, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 12:47:32');
INSERT INTO `t_op_log` VALUES (479, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 12:58:20');
INSERT INTO `t_op_log` VALUES (480, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 12:59:28');
INSERT INTO `t_op_log` VALUES (481, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-06 13:01:37');
INSERT INTO `t_op_log` VALUES (482, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 13:02:24');
INSERT INTO `t_op_log` VALUES (483, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 13:56:42');
INSERT INTO `t_op_log` VALUES (484, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-06 14:38:19');
INSERT INTO `t_op_log` VALUES (485, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 14:38:27');
INSERT INTO `t_op_log` VALUES (486, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 14:38:48');
INSERT INTO `t_op_log` VALUES (487, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 14:39:01');
INSERT INTO `t_op_log` VALUES (488, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-06 14:39:03');
INSERT INTO `t_op_log` VALUES (489, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 14:39:12');
INSERT INTO `t_op_log` VALUES (490, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-06 14:39:15');
INSERT INTO `t_op_log` VALUES (491, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-06 14:39:18');
INSERT INTO `t_op_log` VALUES (492, 2, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-06 15:42:43');
INSERT INTO `t_op_log` VALUES (493, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-07 02:56:27');
INSERT INTO `t_op_log` VALUES (494, 6, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:05:44');
INSERT INTO `t_op_log` VALUES (495, 9, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:05:54');
INSERT INTO `t_op_log` VALUES (496, 9, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-07 03:06:05');
INSERT INTO `t_op_log` VALUES (497, 8, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-07 03:06:28');
INSERT INTO `t_op_log` VALUES (498, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:07:39');
INSERT INTO `t_op_log` VALUES (499, 2, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-07 03:07:52');
INSERT INTO `t_op_log` VALUES (500, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:21:26');
INSERT INTO `t_op_log` VALUES (501, 2, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:27:09');
INSERT INTO `t_op_log` VALUES (502, 2, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:52:21');
INSERT INTO `t_op_log` VALUES (503, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 03:52:43');
INSERT INTO `t_op_log` VALUES (504, 8, 'BROWSE', '浏览了文章: 2026.01.04工作总结', 55, '2026-01-07 04:22:54');
INSERT INTO `t_op_log` VALUES (505, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 04:26:31');
INSERT INTO `t_op_log` VALUES (506, 8, 'BROWSE', '浏览了文章: 美方披露抓获马杜罗更多细节', 56, '2026-01-07 04:26:35');
INSERT INTO `t_op_log` VALUES (507, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 04:26:38');
INSERT INTO `t_op_log` VALUES (508, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 04:29:52');
INSERT INTO `t_op_log` VALUES (509, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 14:13:02');
INSERT INTO `t_op_log` VALUES (510, 8, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-07 14:14:54');
INSERT INTO `t_op_log` VALUES (511, 8, 'BROWSE', '浏览了文章: 咖啡', 62, '2026-01-07 16:05:17');
INSERT INTO `t_op_log` VALUES (512, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 16:12:08');
INSERT INTO `t_op_log` VALUES (513, 8, 'COMMENT', '评论了文章: 123', 65, '2026-01-07 16:12:13');
INSERT INTO `t_op_log` VALUES (514, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 16:25:03');
INSERT INTO `t_op_log` VALUES (515, 8, 'COMMENT', '评论了文章: 为什么评论看不到头像', 65, '2026-01-07 16:25:47');
INSERT INTO `t_op_log` VALUES (516, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 20:22:27');
INSERT INTO `t_op_log` VALUES (517, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 20:30:38');
INSERT INTO `t_op_log` VALUES (518, 8, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-07 20:30:46');
INSERT INTO `t_op_log` VALUES (519, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 20:41:27');
INSERT INTO `t_op_log` VALUES (520, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 20:55:03');
INSERT INTO `t_op_log` VALUES (521, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:04:36');
INSERT INTO `t_op_log` VALUES (522, 8, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-07 21:10:09');
INSERT INTO `t_op_log` VALUES (523, 8, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-07 21:11:00');
INSERT INTO `t_op_log` VALUES (524, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:23:44');
INSERT INTO `t_op_log` VALUES (525, 8, 'COMMENT', '评论了文章: 我来发布一个新评论', 65, '2026-01-07 21:23:56');
INSERT INTO `t_op_log` VALUES (526, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:27:51');
INSERT INTO `t_op_log` VALUES (527, 8, 'COMMENT', '评论了文章: 123', 65, '2026-01-07 21:28:21');
INSERT INTO `t_op_log` VALUES (528, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:30:18');
INSERT INTO `t_op_log` VALUES (529, 8, 'COMMENT', '评论了文章: 123', 65, '2026-01-07 21:30:20');
INSERT INTO `t_op_log` VALUES (530, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:31:51');
INSERT INTO `t_op_log` VALUES (531, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:33:09');
INSERT INTO `t_op_log` VALUES (532, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:38:55');
INSERT INTO `t_op_log` VALUES (533, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:39:15');
INSERT INTO `t_op_log` VALUES (534, 8, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:39:22');
INSERT INTO `t_op_log` VALUES (535, 8, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-07 21:39:36');
INSERT INTO `t_op_log` VALUES (536, 5, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:40:58');
INSERT INTO `t_op_log` VALUES (537, 5, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:42:37');
INSERT INTO `t_op_log` VALUES (538, 5, 'BROWSE', '浏览了文章: 美方披露抓获马杜罗更多细节', 56, '2026-01-07 21:42:53');
INSERT INTO `t_op_log` VALUES (539, 5, 'BROWSE', '浏览了文章: 美方披露抓获马杜罗更多细节', 56, '2026-01-07 21:42:57');
INSERT INTO `t_op_log` VALUES (540, 5, 'BROWSE', '浏览了文章: 国际社会强烈谴责美国对委内瑞拉的军事行动（国际视点）', 59, '2026-01-07 21:43:12');
INSERT INTO `t_op_log` VALUES (541, 5, 'BROWSE', '浏览了文章: 2025.01.06工作总结', 65, '2026-01-07 21:43:14');
INSERT INTO `t_op_log` VALUES (542, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-07 21:43:19');

-- ----------------------------
-- Table structure for t_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回复内容',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回复人',
  `created` datetime NOT NULL COMMENT '回复时间',
  `comment_id` int NOT NULL COMMENT '所属父评论ID',
  `target_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '被回复的目标用户',
  `to_uid` int NULL DEFAULT NULL COMMENT '目标用户ID',
  `user_id` int NULL DEFAULT NULL COMMENT '关联的用户ID',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回复人IP',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP属地',
  `likes` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '子评论/回复表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES (1, '你是谁???', '123', '2025-12-17 00:00:00', 31, '李四', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (2, '回复 @123: 111', '123', '2025-12-17 00:00:00', 31, '123', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (3, '123123', '123', '2025-12-17 00:00:00', 31, '李四', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (4, '123', '123', '2025-12-17 00:00:00', 31, '123', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (5, '现在时几点?\n', '123', '2025-12-17 02:51:33', 31, '李四', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (6, '你好', '123', '2025-12-17 02:54:17', 30, '123', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (7, '尼克狐尼克,你被捕了', '123', '2025-12-17 03:21:42', 34, '123', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (8, '你好', 'admin', '2025-12-17 16:58:19', 34, '123', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (9, '我来回复一下', 'admin', '2025-12-17 18:05:01', 33, '李四', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (10, '怎么这么奇怪', 'zzt', '2025-12-17 21:20:08', 44, 'zzt', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (11, '好的', 'zzt', '2025-12-18 04:43:10', 45, 'zzt', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (12, '好的', 'zzt', '2025-12-18 04:43:19', 45, 'zzt', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (13, '怎么又有问题了\n', 'zzt', '2025-12-18 04:43:49', 45, 'zzt', NULL, 1, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (14, '现在没问题了吧', 'zzt', '2025-12-18 07:07:10', 45, NULL, NULL, 6, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (15, '怎么你的用户名是Null', 'zzt', '2025-12-18 07:07:47', 45, NULL, NULL, 6, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (16, '因为我将索引设置为user_id而不是author,而我的user_id没有内容所以显示为null', 'zzt', '2025-12-18 07:09:56', 45, NULL, 6, 6, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (17, '123456', 'zzt', '2026-01-02 04:07:43', 45, NULL, 6, 6, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (18, '新年快乐', 'zzt', '2026-01-02 04:14:17', 46, NULL, NULL, 6, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (19, '新年快乐', '123', '2026-01-02 04:14:30', 46, NULL, 6, 5, NULL, NULL, 0);
INSERT INTO `t_reply` VALUES (20, '怎么是未知星球', '123', '2026-01-03 00:30:34', 53, NULL, NULL, 5, '142.249.36.58', '未知星球', 0);
INSERT INTO `t_reply` VALUES (21, '怎么是法国电信', '123', '2026-01-03 00:35:04', 55, NULL, NULL, 5, '141.11.146.76', '法国|0|0|法国电信', 0);
INSERT INTO `t_reply` VALUES (22, '为什么是法国电信', '123', '2026-01-03 06:19:16', 55, NULL, NULL, 5, '141.11.146.76', '法国|0|0|法国电信', 0);
INSERT INTO `t_reply` VALUES (23, '现在呢', '123', '2026-01-03 06:21:16', 55, NULL, 5, 5, '45.147.201.215', '荷兰|0|0|0', 0);
INSERT INTO `t_reply` VALUES (24, '怎么数据库存储荷兰然后回复显示法国', '123', '2026-01-03 06:23:29', 55, NULL, 5, 5, '45.147.201.215', '荷兰|0|0|0', 0);
INSERT INTO `t_reply` VALUES (25, '再看看', 'zzt', '2026-01-03 06:24:00', 55, NULL, 5, 6, '192.168.1.100', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (26, '居然是这样', 'zzt', '2026-01-03 06:26:45', 57, NULL, NULL, 6, '192.168.1.100', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (27, '看看你的', 'admin', '2026-01-03 18:34:50', 58, NULL, NULL, 1, '192.168.1.100', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (28, '我来回复一下你', '123', '2026-01-04 01:26:08', 58, NULL, NULL, 5, '192.168.1.100', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (29, '你好', '123', '2026-01-04 01:45:16', 60, NULL, NULL, 5, '142.249.36.185', '加拿大|0|0|0', 0);
INSERT INTO `t_reply` VALUES (30, '回复一下你的评论', '123', '2026-01-04 01:58:49', 56, NULL, NULL, 5, '142.249.36.185', '加拿大|0|0|0', 0);
INSERT INTO `t_reply` VALUES (31, '你好,新年快乐', '123', '2026-01-04 02:35:36', 75, NULL, NULL, 5, '192.168.1.100', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (32, '学的怎么样了', 'zzt', '2026-01-04 08:05:37', 3, NULL, NULL, 6, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (33, '本地局域网。。。', '李四', '2026-01-04 08:25:18', 77, NULL, NULL, 2, '192.168.1.105', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (34, '加拿大', '李四', '2026-01-04 08:25:28', 62, NULL, NULL, 2, '192.168.1.105', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (36, '我怎么发不了评论但是可以回复别人的评论', '李四', '2026-01-04 10:31:54', 82, NULL, NULL, 2, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (37, '你好', 'tom', '2026-01-04 10:32:46', 82, NULL, 2, 4, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (38, '我才发现评论区连emoji都不支持...', 'zzt', '2026-01-04 10:36:41', 85, NULL, NULL, 6, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (39, '哦咦系', 'tom', '2026-01-04 11:28:37', 87, NULL, NULL, 4, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (40, '怎么这样的', 'tom', '2026-01-04 11:29:13', 82, NULL, 2, 4, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (41, '回复一下你', 'zzt', '2026-01-04 11:35:01', 44, NULL, 1, 6, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (43, '并非好地方', '尊贵的iPhone17ProMax用户', '2026-01-04 11:49:52', 88, NULL, NULL, 7, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (44, '你好', 'admin', '2026-01-04 13:19:31', 44, NULL, NULL, 1, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (45, '你看现在就消失了', 'tom', '2026-01-04 13:40:09', 93, NULL, NULL, 4, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (46, '再看看', 'tom', '2026-01-05 07:37:49', 53, NULL, NULL, 4, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (47, '是的,我感觉还不错', '王德志', '2026-01-05 13:23:14', 105, NULL, NULL, 8, '142.249.36.185', '加拿大|0|0|0', 0);
INSERT INTO `t_reply` VALUES (48, '你好', 'admin', '2026-01-05 13:35:04', 104, NULL, NULL, 1, '142.249.36.185', '加拿大|0|0|0', 0);
INSERT INTO `t_reply` VALUES (49, '怎么是法国电信', '王德志', '2026-01-05 13:49:01', 109, NULL, NULL, 8, '141.11.146.76', '法国|0|0|法国电信', 0);
INSERT INTO `t_reply` VALUES (50, '现在又是哪', '王德志', '2026-01-05 13:49:15', 109, NULL, 8, 8, '141.11.146.76', '法国|0|0|法国电信', 0);
INSERT INTO `t_reply` VALUES (51, '再看看现在', '王德志', '2026-01-05 13:49:34', 109, NULL, 8, 8, '141.11.146.76', '法国|0|0|法国电信', 0);
INSERT INTO `t_reply` VALUES (52, '123', '李四', '2026-01-06 15:42:56', 106, NULL, NULL, 2, '120.235.59.235', '中国|广东省|东莞市|移动', 0);
INSERT INTO `t_reply` VALUES (53, '456', '王德志', '2026-01-07 03:21:34', 106, NULL, 2, 8, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (54, '哇塞', '王德发', '2026-01-07 04:26:45', 106, NULL, 8, 8, '192.168.1.102', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (55, '我现在来回复你一下', '王德发', '2026-01-07 16:25:16', 114, NULL, NULL, 8, '141.11.146.77', '法国|0|0|法国电信', 0);
INSERT INTO `t_reply` VALUES (56, '我来试试emoji功能😊', '王德发', '2026-01-07 20:22:52', 115, NULL, NULL, 8, '192.168.1.101', '本地局域网', 0);
INSERT INTO `t_reply` VALUES (57, '？？？', '王德顺', '2026-01-07 21:39:09', 116, NULL, NULL, 8, '192.168.1.101', '本地局域网', 0);

-- ----------------------------
-- Table structure for t_reply_like
-- ----------------------------
DROP TABLE IF EXISTS `t_reply_like`;
CREATE TABLE `t_reply_like`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `reply_id` int NOT NULL,
  `created` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_reply`(`user_id` ASC, `reply_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_reply_like
-- ----------------------------

-- ----------------------------
-- Table structure for t_statistic
-- ----------------------------
DROP TABLE IF EXISTS `t_statistic`;
CREATE TABLE `t_statistic`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL COMMENT '关联的文章id',
  `hits` int NOT NULL DEFAULT 0 COMMENT '文章点击总量',
  `comments_num` int NOT NULL DEFAULT 0 COMMENT '文章评论总量',
  `likes` int NOT NULL DEFAULT 0 COMMENT '点赞数',
  `prev_read_rank` int NULL DEFAULT 0 COMMENT '上次阅读排名',
  `read_rank_change` int NULL DEFAULT 0 COMMENT '阅读排名变化(正升负降)',
  `prev_like_rank` int NULL DEFAULT 0 COMMENT '上次点赞排名',
  `like_rank_change` int NULL DEFAULT 0 COMMENT '点赞排名变化(正升负降)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_statistic
-- ----------------------------
INSERT INTO `t_statistic` VALUES (1, 1, 110, 5, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (2, 2, 4, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (3, 3, 8, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (4, 4, 4, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (5, 5, 6, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (6, 6, 18, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (7, 7, 6, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (8, 8, 27, 1, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (9, 9, 23, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (10, 10, 19, 1, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (11, 11, 11, 1, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (12, 12, 43, 1, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (13, 20, 40, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (14, 19, 16, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (15, 18, 6, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (16, 15, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (17, 17, 4, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (18, 21, 17, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (19, 22, 33, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (20, 23, 26, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (21, 24, 34, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (22, 25, 7, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (23, 26, 6, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (24, 27, 11, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (25, 28, 24, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (26, 29, 7, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (27, 30, 63, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (28, 16, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (29, 31, 4, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (30, 32, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (31, 33, 2, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (32, 34, 7, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (33, 35, 3, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (34, 36, 6, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (35, 37, 11, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (36, 38, 5, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (37, 39, 7, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (38, 40, 10, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (39, 41, 128, 0, 7, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (40, 42, 37, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (52, 54, 9, 0, 1, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (53, 55, 10, 0, 4, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (54, 56, 5, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (57, 59, 7, 0, 0, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (60, 62, 24, 0, 3, 0, 0, 0, 0);
INSERT INTO `t_statistic` VALUES (63, 65, 28, 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (8, '2018');
INSERT INTO `t_tag` VALUES (29, 'bug');
INSERT INTO `t_tag` VALUES (33, 'coffee');
INSERT INTO `t_tag` VALUES (23, 'Docker');
INSERT INTO `t_tag` VALUES (15, 'Go语言');
INSERT INTO `t_tag` VALUES (36, 'Hong Kong');
INSERT INTO `t_tag` VALUES (9, 'Java');
INSERT INTO `t_tag` VALUES (20, 'JDK 8');
INSERT INTO `t_tag` VALUES (17, 'Lambda表达式');
INSERT INTO `t_tag` VALUES (14, 'PHP');
INSERT INTO `t_tag` VALUES (11, 'Python');
INSERT INTO `t_tag` VALUES (27, 'Spring Boot 2');
INSERT INTO `t_tag` VALUES (31, 'test');
INSERT INTO `t_tag` VALUES (30, '交流');
INSERT INTO `t_tag` VALUES (19, '函数式接口');
INSERT INTO `t_tag` VALUES (13, '前端与移动');
INSERT INTO `t_tag` VALUES (16, '区块链');
INSERT INTO `t_tag` VALUES (35, '咖啡');
INSERT INTO `t_tag` VALUES (7, '委内瑞拉');
INSERT INTO `t_tag` VALUES (46, '学习');
INSERT INTO `t_tag` VALUES (12, '学习线路图');
INSERT INTO `t_tag` VALUES (10, '学习路线图');
INSERT INTO `t_tag` VALUES (25, '客户端指令');
INSERT INTO `t_tag` VALUES (40, '总结');
INSERT INTO `t_tag` VALUES (28, '技术实现');
INSERT INTO `t_tag` VALUES (39, '抹茶');
INSERT INTO `t_tag` VALUES (18, '接口');
INSERT INTO `t_tag` VALUES (26, '数据管理');
INSERT INTO `t_tag` VALUES (3, '新闻');
INSERT INTO `t_tag` VALUES (2, '时政');
INSERT INTO `t_tag` VALUES (41, '李四');
INSERT INTO `t_tag` VALUES (32, '测试');
INSERT INTO `t_tag` VALUES (1, '热点');
INSERT INTO `t_tag` VALUES (34, '美饮');
INSERT INTO `t_tag` VALUES (21, '聚合操作');
INSERT INTO `t_tag` VALUES (22, '虚拟化容器');
INSERT INTO `t_tag` VALUES (24, '运行机制');
INSERT INTO `t_tag` VALUES (38, '香港');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户头像',
  `created` datetime NULL DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', '2127269782@qq.com', NULL, '2018-10-01 00:00:00', 1);
INSERT INTO `t_user` VALUES (2, '李四', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', '1768653040@qq.com', '/api/file/images/a03f0ee6-59e7-46ea-9441-62790e1d63eb.png', '2018-11-13 00:00:00', 1);
INSERT INTO `t_user` VALUES (3, '东方不败', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', '13718391550@163.com', NULL, '2018-12-18 00:00:00', 1);
INSERT INTO `t_user` VALUES (4, 'tom', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', 'asexeees@sohu.com', NULL, '2018-12-03 00:00:00', 1);
INSERT INTO `t_user` VALUES (5, '123', '$2a$10$.M5V2dSiG0FWYyB4JfqsqOgeFmoPFzUgHQRjpyuDJ/IKcJsses0xq', '123456@qq.com', NULL, '2025-12-09 00:00:00', 1);
INSERT INTO `t_user` VALUES (6, 'zzt', '$2a$10$zZ5vFs0ArzFW6.yUay/8iOaHk5.XgLspxH0AX2osoQ.CW.gEaBbu.', '12345677@qq.com', '/api/file/images/414c2b1a-101e-4f27-ae3a-148293c04d7b.jpg', '2025-12-17 00:00:00', 1);
INSERT INTO `t_user` VALUES (7, '尊贵的iPhone17ProMax用户', '$2a$10$Bs9s8O8jyKY03YbQAw5rfetElexv8KBHWrCRUB2ZzYX6p/MJ2s.8O', 'wannamanymanymoney@gmail.com', NULL, '2026-01-04 00:00:00', 1);
INSERT INTO `t_user` VALUES (8, '王德顺', '$2a$10$axeG8E1aB/95BmasLaN7O.OnjheQ85UU/xJGNPvDUSGvWT.EFz2am', '2765309445@qq.com', '/api/file/images/414c2b1a-101e-4f27-ae3a-148293c04d7b.jpg', '2026-01-05 23:10:45', 1);
INSERT INTO `t_user` VALUES (9, '机器人', '$2a$10$bmJKkp.qEMAHEghnCUH9OOvM1YgRR.k3GHCQgKRbeZM8fvxcceS4a', 'zzt57502@gmail.com', NULL, '2026-01-05 00:00:00', 1);
INSERT INTO `t_user` VALUES (10, '我不是马神', '$2a$10$nC.nReCreYVwMqhr0mdCN.6AxbMuHRNpKAWuLc5Bp23C17RVe8G3S', 'zzt1638415095@gmail.com', NULL, '2026-01-05 00:00:00', 1);
INSERT INTO `t_user` VALUES (11, '123hhk', '$2a$10$QCEmW8g175odIFUf6CSTxeM2l8Z2djQgznGXluVrkZD3tyhGvnela', '2492817172@qq.com', NULL, '2026-01-05 00:00:00', 1);

-- ----------------------------
-- Table structure for t_user_authority
-- ----------------------------
DROP TABLE IF EXISTS `t_user_authority`;
CREATE TABLE `t_user_authority`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '关联的用户id',
  `authority_id` int NOT NULL COMMENT '关联的权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user_authority
-- ----------------------------
INSERT INTO `t_user_authority` VALUES (1, 1, 1);
INSERT INTO `t_user_authority` VALUES (2, 2, 2);
INSERT INTO `t_user_authority` VALUES (3, 3, 2);
INSERT INTO `t_user_authority` VALUES (4, 4, 2);
INSERT INTO `t_user_authority` VALUES (5, 5, 2);
INSERT INTO `t_user_authority` VALUES (6, 6, 2);
INSERT INTO `t_user_authority` VALUES (7, 7, 2);
INSERT INTO `t_user_authority` VALUES (8, 8, 2);
INSERT INTO `t_user_authority` VALUES (9, 9, 2);
INSERT INTO `t_user_authority` VALUES (10, 10, 2);
INSERT INTO `t_user_authority` VALUES (11, 11, 2);

SET FOREIGN_KEY_CHECKS = 1;
