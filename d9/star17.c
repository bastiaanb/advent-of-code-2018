#include<stdio.h>

int players=446;
int marbles=7152200;

int score[446];
int previous[7152200];
int next[7152200];

int main(int argc, char** argv) {
  int current=0;
  int m, player, i, n, p, remove;

  for (m=1, player=1; m <= marbles; m++, player=(player + 1) % players ) {
    if ((m % 23) == 0) {
      current=previous[current];
      current=previous[current];
      current=previous[current];
      current=previous[current];
      current=previous[current];
      current=previous[current];
      remove=previous[current];
      p=previous[remove];
      next[p]=current;
      previous[current]=p;
      score[player]+=(m + remove);
    } else {
      p=next[current];
      n=next[p];
      previous[m]=p;
      next[m]=n;
      next[p]=m;
      previous[n]=m;
      current=m;
    }
  }

  for (i=0; i < players; i++) {
    printf("%ld %ld\n", i, score[i]);
  }
}
