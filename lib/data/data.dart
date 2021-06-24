class SliderModel {
  String imagePath, title, desc;

  SliderModel({this.imagePath, this.title, this.desc});

  void setImageAssetPath(String getImagePath) {
    imagePath = getImagePath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImagePath() {
    return imagePath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();

  SliderModel sliderModel = new SliderModel();
  sliderModel
      .setDesc("Discover good quality and environment friendly products");
  sliderModel.setTitle("Eco Friendly Products");
  sliderModel.setImageAssetPath("assets/tag.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Every time you buy a product, 2% of total cost will help us to plant a tree");
  sliderModel.setTitle("We will plant a tree for you");
  sliderModel.setImageAssetPath("assets/tree.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel
      .setDesc("Buying sustainable products you help in reducing plastic ");
  sliderModel.setTitle("Say no to plastic products");
  sliderModel.setImageAssetPath("assets/plasticfree.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
