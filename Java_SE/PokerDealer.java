public class PokerDealer {
    public static void main(String[] args) {
        String[] cards = new String[53];
        String[][] players = new String[4][13];
        String[] suits = {"梅花", "方塊", "紅心", "黑桃"};
        int[] playerCardIndex = new int[4];

        int cardNumber = 1;
        for (int i = 1; i <= 13; i++){
            for (String suit : suits) {
                cards[cardNumber] = suit + i;
                System.out.printf("%s\t", cards[cardNumber]);
                cardNumber++;
            }
            System.out.println();
        }

        System.out.println("------ After Shuffle ------");

        for (int i = 1; i < cards.length; i++){
            int randPlayer;

            do { randPlayer = (int) (Math.random() * 4); }
            while (playerCardIndex[randPlayer] == 13 &&
                    (playerCardIndex[0] != 13 || playerCardIndex[1] != 13 ||
                            playerCardIndex[2] != 13 || playerCardIndex[3] != 13));

            players[randPlayer][playerCardIndex[randPlayer]++] = cards[i];
        }

        for (int i = 0; i < players.length; i++) {
            System.out.printf("Player %d : ", i + 1);
            for (String card : players[i]) {
                System.out.printf("%s \t", card);
            }
            System.out.println();
        }
    }
}
