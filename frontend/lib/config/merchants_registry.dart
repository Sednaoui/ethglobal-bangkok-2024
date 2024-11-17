import 'package:phosphor_flutter/phosphor_flutter.dart';

class MerchantsRegistry {

  static Map<String, (String, PhosphorIconData)> groups = {
    "6377c45cecbe1f20eaf46bd3f27ae079882e88d579f5eed558666cd6bfd75606": ("Education", PhosphorIcons.student()),
    "7f10eddc75153e5c78d3b132087db7a02de3651c1bafbeaef5f3b164a37f8585": ("Entertainment", PhosphorIcons.monitorPlay()),
    "e4fe31345baaf3423c6ba65a156870d39380211cfeaa9325c7c6b54cc880a954": ("Hobbies and Crafts", PhosphorIcons.courtBasketball()),
    "de59c3a856b17480deaabb952c14593c5b0ad99e0eb47a8b99ac4fba75ac9c45": ("Charitable Giving", PhosphorIcons.heartbeat()),
  };

  static Map<String, String> descriptions = {
    // Education
    "c5f5c9a620967d9de71e6cb8d37bb862cca8a13a7b620299a1421e90bb874b18": "Duolingo is a fun and engaging language-learning app that uses games and challenges to teach a variety of languages. It's great for kids as it offers bite-sized lessons that are interactive, making learning feel like play.",
    "d8db3194bfbff98827cfae9f82b38758b8b47ae1cbe65b341a2196f51f8dafc2": "Barnes & Noble is a popular bookstore offering a wide selection of books, including educational materials, children's books, and more. It's a great place to encourage a love for reading with a huge variety of titles for kids of all ages.",
    "a09e3f4552562c259ba181805df5668d4f2c439c706c7aa8d154922069657f0b": "Varsity Tutors offers personalized tutoring services for a range of subjects. It provides expert tutors who can help your child improve in academics, with both online and in-person options for flexible learning.",
    // Entertainment
    "1d16c9ee7f879ac0cdd62cfd49d7af2af365d0d3c33bc098819e9292c2825f23": "The Epic Games Store offers a wide range of video games, with a section specifically curated for PG-13 rated games. It's a great option for kids as it provides access to age-appropriate games, ensuring a safe and fun gaming experience.",
    "34f0485ece4ae041875f5f8c1bc269c31bbcf03e382f81bcf2ce773388caaaf0": "Netflix Kids is a kid-friendly version of the popular streaming service, offering a wide range of age-appropriate TV shows, movies, and educational content. It's ideal for kids as it provides a safe environment with content tailored to different age groups..",
    // Hobbies and Crafts
    "6b27ffd60ee359fd80db136198c8658a0ed325b10ad7fcbeb6ee3b1699e3f28a": "Decathlon is a global retailer offering a wide range of sports equipment and outdoor gear. It's perfect for kids who enjoy sports and outdoor activities, with affordable, high-quality products for various sports and active lifestyles.",
    "3693d629ace6d58740185a4b21125f4c71a13d2f302237de0342a141c06a089f": "LEGO offers a creative and educational building experience through its iconic plastic brick sets. It's great for kids as it encourages imagination, problem-solving, and hands-on learning while providing hours of fun with endless building possibilities.",
    // Charitable Giving
    "c44a3aeb22741b6ba7f6caf1c1ca65262f3bffe4ad1ff4840c6723637322b624": "Save the Children is a global nonprofit that focuses on improving the lives of children in need, providing education, healthcare, and emergency relief. It's a great way to teach kids about compassion, humanitarian efforts, and how they can help children around the world.",
    "b4aa9456856879ed344ba6f4593dcfce6f9de69972ae30c11eae26f1d7828ca9": "Doctors Without Borders (Médecins Sans Frontières) provides medical care in crisis zones worldwide. It's an excellent way to inspire kids with stories of doctors and nurses who selflessly help those in need, promoting empathy and awareness of global health challenges.",
  };

  static Map<String, String> logos = {
    // Education
    "243485bf02fb27183abbd49b91055cede8e0782f3bb7e034ef61b4f8e7fd2613": "https://seeklogo.com/images/D/duolingo-logo-DB18C5E638-seeklogo.com.png",
    "b4b1c857ea05e84b290411cb2b15085e963f3bf848ce5e97a7fc19c263523170": "https://www.destinyusa.com/wp-content/uploads/2016/09/BarnesNoble_2022_WEB-200x200.png",
    "3a87b666643d2c7d2a5f577d980f6b2d93501cab5cee8816f81b801672e015b7": "https://assets.clever.com/resource-icons/apps/6108890aac7b7300015f13b9/icon_cffd16a.png",
    // Entertainment
    "46b58c0cd65bedfc27b7c102671677588c4e74dc409e6053345afec552a3f9e7": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Epic_Games_logo.svg/1764px-Epic_Games_logo.svg.png",
    "dfaaad262e1d4fd4ae8587aa9457c52dc5eb365b56ce6e9bfd3d1e92446652b5": "https://loodibee.com/wp-content/uploads/Netflix-N-Symbol-logo.png",
    // Hobbies and Crafts
    "baa8b16d8f5a2fe8ad647eba12ebae338df4f7bf03c54f2d21cca198096726ec": "https://londonsport.org/wp-content/uploads/2024/04/Decathlon-Logo-500x281-1.png",
    "132fffe4c8cb13b3a9a3eaaa3f8822e87eded8ad5ddb6b10aee594d7d40e0a60": "https://pngimg.com/d/lego_PNG85.png",
    // Charitable Giving
    "f69383697bdd1fda12bb338be32b5a6e1e9c9606d79a21941cff947894c73373": "https://avatars.githubusercontent.com/u/29430242?s=280&v=4",
    "556f12bfdc1043ba40485cff2de0442475927f3eace11560ee103122e2c1286b": "https://techjobsforgood-prod.s3.amazonaws.com/company_profile_photos/6b028bf6-5d2f-462c-b47d-85540a244adc-20191105-172120.png",
  };

  static List<(String, PhosphorIconData)> getGroupsData(){
    List<(String, PhosphorIconData)> groupsNames = [];
    groupsNames.addAll(groups.values);
    return groupsNames;
  }
}