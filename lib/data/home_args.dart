enum HomeType { 
   house,
   apartment
}

class HomeArgs {
  int homeId;
  HomeType homeType;
  HomeArgs(this.homeId, this.homeType);
}