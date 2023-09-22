const mobileWidth = 640;
const tabletWidth = 1000;

enum DeviceType { mobile, tablet, pc }

dynamic checkDevice(double maxWidth, mobile, tablet, pc) {
  if (maxWidth > mobileWidth) {
    if (maxWidth > tabletWidth) {
      return pc;
    }
    return tablet;
  }
  return mobile;
}
