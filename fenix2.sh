#!/bin/bash
#/etc/init.d/resize_write
### BEGIN INIT INFO
# Provides:          resize_write
# Required-Start:    $syslog
# Required-Stop:     $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: add service resize_write
# Description:
#
### END INIT INFO

#Function to change SSID
chooseName () {
    #This generate a random number
    INDEX=$((RANDOM % 307 ));
    ANIMALS=(
        "aardvark"
        "albatross"
        "alligator"
        "alpaca"
        "anaconda"
        "ant"
        "anteater"
        "antelope"
        "ape"
        "armadillo"
        "ass"
        "baboon"
        "badger"
        "bandicoot"
        "barracuda"
        "basilisk"
        "bat"
        "bear"
        "beaver"
        "bee"
        "bighorn sheep"
        "bird"
        "bison"
        "black bear"
        "boa constrictor"
        "boar"
        "bobcat"
        "brown bear"
        "buck"
        "budgerigar"
        "buffalo"
        "bull"
        "bunny"
        "burro"
        "butterfly"
        "calf"
        "camel"
        "canary"
        "caribou"
        "cat"
        "caterpillar"
        "catfish"
        "chameleon"
        "chamois"
        "cheetah"
        "chicadee"
        "chick"
        "chicken"
        "chimpanzee"
        "chinchilla"
        "chipmunk"
        "civet"
        "coati"
        "cobra"
        "cockatoo"
        "cockroach"
        "colt"
        "cony"
        "cormorant"
        "cougar"
        "cow"
        "coyote"
        "crab"
        "crane"
        "crocodile"
        "crow"
        "cub"
        "deer"
        "dingo"
        "dodo"
        "doe"
        "dog"
        "dogfish"
        "dolphin"
        "donkey"
        "dormouse"
        "dove"
        "dragonfly"
        "drake"
        "dromedary"
        "duck"
        "duckbill"
        "dugong"
        "eagle"
        "echidna"
        "eel"
        "egret"
        "eland"
        "elephant"
        "elephant seal"
        "elk"
        "emu"
        "ermine"
        "ewe"
        "falcon"
        "fawn"
        "ferret"
        "filly"
        "finch"
        "fire ant"
        "fish"
        "flamingo"
        "fly"
        "foal"
        "fox"
        "frog"
        "gander"
        "gazelle"
        "gecko"
        "gemsbok"
        "gerbil"
        "gila monster"
        "gilla monster"
        "giraffe"
        "gnu"
        "goat"
        "goose"
        "gopher"
        "gorilla"
        "grizzly bear"
        "ground hog"
        "guanaco"
        "guinea pig"
        "gull"
        "hamster"
        "hare"
        "hartebeest"
        "hawk"
        "hedgehog"
        "hen"
        "heron"
        "hippopotamus"
        "hog"
        "hornet"
        "horse"
        "human"
        "hummingbird"
        "hyena"
        "ibex"
        "iguana"
        "impala"
        "jackal"
        "jaguar"
        "jellyfish"
        "jerboa"
        "joey"
        "kangaroo"
        "kid"
        "killer whale"
        "kingfisher"
        "kinkajou"
        "kitten"
        "koala"
        "komodo dragon"
        "lamb"
        "lark"
        "lemming"
        "lemur"
        "leopard"
        "lion"
        "lizard"
        "llama"
        "lobster"
        "locust"
        "louse"
        "lovebird"
        "lynx"
        "macaw"
        "magpie"
        "mallard"
        "manatee"
        "mandrill"
        "manta ray"
        "mare"
        "marmoset"
        "marmot"
        "marten"
        "meerkat"
        "mink"
        "mole"
        "mongoose"
        "monkey"
        "moose"
        "mosquito"
        "mountain goat"
        "mountain lion"
        "mouse"
        "mule"
        "mule"
        "musk deer"
        "musk-ox"
        "muskrat"
        "mustang"
        "mynah bird"
        "narwhal"
        "newt"
        "newt"
        "nightingale"
        "ocelot"
        "octopus"
        "okapi"
        "opossum"
        "orangutan"
        "orca"
        "oryx"
        "osprey"
        "ostrich"
        "otter"
        "owl"
        "ox"
        "oyster"
        "panda"
        "panther"
        "parakeet"
        "parrot"
        "partridge"
        "peacock"
        "peccary"
        "pelican"
        "penguin"
        "pig"
        "pigeon"
        "piglet"
        "platypus"
        "polar bear"
        "polecat"
        "pony"
        "porcupine"
        "porpoise"
        "prairie dog"
        "pronghorn"
        "pufferfish"
        "puffin"
        "puma"
        "puppy"
        "python"
        "quail"
        "rabbit"
        "raccoon"
        "ram"
        "rat"
        "rattlesnake"
        "raven"
        "reindeer"
        "reptile"
        "rhinoceros"
        "roebuck"
        "rooster"
        "salamander"
        "salmon"
        "seahorse"
        "seal"
        "sea lion"
        "seastar"
        "shark"
        "sheep"
        "shrew"
        "silver fox"
        "skink"
        "skunk"
        "sloth"
        "snail"
        "snake"
        "sparrow"
        "spider"
        "spider monkey"
        "springbok"
        "squid"
        "squirrel"
        "stag"
        "stallion"
        "starfish"
        "steer"
        "sting ray"
        "stinkbug"
        "stork"
        "swallow"
        "swan"
        "tadpole"
        "tapir"
        "tern"
        "tiger"
        "toad"
        "tortoise"
        "turkey"
        "turtle"
        "vicuna"
        "vulture"
        "wallaby"
        "wallaroo"
        "walrus"
        "warthog"
        "wasp"
        "waterbuck"
        "water buffalo"
        "weasel"
        "whale"
        "wildcat"
        "wildebeest"
        "wolf"
        "wolverine"
        "wombat"
        "woodchuck"
        "woodpecker"
        "worm"
        "yak"
        "zebra"
        )

 #This asign a name from the list to the ssidName.
 SSID_NAME=${ANIMALS[INDEX]}; 
 #Changing the SSID Name
 FILE="/etc/hostapd/hostapd.conf";
 LINE=$(grep SSID prueba);
 #Replacing name.
 sed -i "s/default/Netbeast-$SSID_NAME/g" $FILE

}

case "$1" in
  start)
chooseName
echo "Starting resize_write "
        fdisk /dev/mmcblk0 <<EOF
        p
        d
        2
        n
        p
        2
        122880

        p
        w
EOF

        #So far, we have change the partition size table, now we have to create a service to be executed once and then change
        #the partition for real.

        #We must create a service to be executed on boot and then delete it for not being executed anymore.

        echo "#!/bin/bash" > /etc/init.d/resize_execute
        echo "#/etc/init.d/resize_execute" >> /etc/init.d/resize_execute
        echo "### BEGIN INIT INFO" >> /etc/init.d/resize_execute
        echo "# Provides:          resize_execute" >> /etc/init.d/resize_execute
        echo "# Required-Start:     \$syslog" >> /etc/init.d/resize_execute
        echo "# Required-Stop:      \$syslog" >> /etc/init.d/resize_execute
        echo "# Default-Start:    2 3 4 5" >> /etc/init.d/resize_execute
        echo "# Default-Stop:     0 1 6" >> /etc/init.d/resize_execute
        echo "# Short-Description: Resize the root filesystem to fill partition" >> /etc/init.d/resize_execute
        echo "# Description:" >> /etc/init.d/resize_execute
        echo "### END INIT INFO" >> /etc/init.d/resize_execute

        echo "case \"\$1\" in" >> /etc/init.d/resize_execute
        echo "start)" >> /etc/init.d/resize_execute
echo "Resizing filesystem" >> /etc/init.d/resize_execute
echo "resize2fs /dev/mmcblk0p2" >> /etc/init.d/resize_execute
echo "update-rc.d resize_execute remove" >> /etc/init.d/resize_execute
echo "rm /etc/init.d/resize_write" >> /etc/init.d/resize_execute
echo "rm /etc/init.d/resize_execute" >> /etc/init.d/resize_execute
echo ";;" >> /etc/init.d/resize_execute
echo "*)" >> /etc/init.d/resize_execute
echo "echo \"[Just run on boot]\""
echo "exit 1" >> /etc/init.d/resize_execute
echo ";;" >> /etc/init.d/resize_execute
echo "esac" >> /etc/init.d/resize_execute
echo "exit 0" >> /etc/init.d/resize_execute

chmod +x /etc/init.d/resize_execute
update-rc.d resize_execute defaults
update-rc.d resize_write remove
reboot
;;
*)
echo "[RESIZE]Resize on next boot"
exit 1
;;
esac
exit 0
