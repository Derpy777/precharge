use "files"
use "lib:Memoire"

use @GetPourcentUse[U32]()
use @GetTotalPhysMemoire[USize]()
use @GetFreePhysMemoire[USize]()
use @GetTotalPageFile[USize]()
use @GetFreePageFile[USize]()
use @GetTotalVirtualMemory[USize]()
use @GetFreeVirtualMemory[USize]()
use @GetFreeExtVirtualMem[USize]()


class Credits

  let _pony: String = """

+++:++++++:++:++:+++::+::+::+::+::+::+::+::+::+::+::+::+
::::::+::+:++:++:+++::+::+::+::+::+::+::+::+::+::+::+::+
::::::::::::::++++:+::++++::+::+::+::+::+::+::+::+::+::+
++++:++:++:++:++#@@@@@@#=*=##*++::+::+:++::+::+::+::+::+
:+:::::::+:++:++++=@@@@@@@@@@###+-.--..-.....-----:::::+
++++++++++:+=##################*.....................-++
::::::::+=####################+.....................::::
:+::::+*####@@#@@@@@@#########*...................-++::+
++++++=##*#@@@@@@@@######+#####:................:+++++++
::::+==++@@@@@@@@######*.*#####-.............-::::::::::
:+:+++:+@@@@@@@#######*..-*###*...........:*::++::::::::
+++++++@=:::++*=######....-###-......:=######+++++::::::
::::::#@@#:----+#####+....:###@=-...-#########+:::::::::
:+:::*@@@@@#+-*######-.-#@*#+#@:....+##########+:+::+::+
+++++#@@@@#########=-:W@*.=:.-W-...-########@###*:++++++
::::*@=@@########=--#@@@#:...-W-..-####@####@@#*#=::::::
:+::*=*@########-..#@@@@@:...#@:.-####@#####@@#=::+++::+
+++++:*@#####=++-..*@@@@=.:@#-..-###@@@####@@@@@++++++++
::::::=####=+::::...+:-+#+-....-##=@@@@####@@@@@=+::::::
:+:::+####+::::::...--.........*#-=@@@####@@@@@@@+::+::+
++++++*#=+++++:-..:...........-=-:@@@####@@@@@@@@*++++++
::::::+=:::::::-...............-.=@@@###@@@@@@#@@=::::::
:+::::+::+:++:++::--.........-..-@@@####@@@@@@=+@*::+::+
+++++++++++++++++++::-..--*##...+@@@####@@@@@@*+++++++++
:::::::::::::::::::::::::=##+...=@@@###@@@@@@#::::::::::
:+::::+::+:++:++:+++::++###=....@@#####@@@@@@*+::+::+::+
++++++++++++++++++++++*####-....@@*#####@@@@=+++++++++++
::::::::::::::::::::+####@:.....*@+#####@@@@+:::::::::::
:+::::+::+:++:++:+*#=*#@@:.......+*+####@@@=::+::+::+::+
+++++++++++++++++++++@@@@:.........-####@@@+++++++++++++

                      """


  let _credits: String = """

                      D‚di‚ aux membres de JVC et de la GDC, vive la Master-Race... :D

                         """

  let _argsIncorrects: String = """
                                       
                      Nombre d'arguments incorrects !

                                """



  let _version: String = "1.3.0"

  let _usage: String = """
                      USAGE :
                             
                      precache.exe -r "LeChemin" : Charge tout ce qu'il y a dans <LeChemin> dans la RAM

                      precache.exe -f "LeChemin" : Charge tout ce qu'il y a dans <LeChemin> dans la RAM sans v‚rifier la m‚moire libre
                              
                      precache.exe -v : Affiche le numero de version du programme

                      precache.exe --memoire : affiche des infos sur la m‚moire de Windows

                      precache.exe --credits : Affiche les cr‚dits !
                             
                      """

  let _bienvenue: String = """
                    -------------------------------------------
                    Programme r‚alis‚ et cod‚ en PONY par Derpy
                    -------------------------------------------

                    """

  let _aurevoir: String = """
                            
                      Mise dans la RAM effectu‚e... Have Fun!   :)
                     
                      """


  

  fun getUsage(): String => _usage
  fun getBienvenue(): String => _bienvenue
  fun getAurevoir(): String => _aurevoir
  fun getArgsIncorrects(): String => _argsIncorrects
  fun getVersion(): String => _version
  fun getCredits(): String => _credits
  fun getPony(): String => _pony






primitive Travail
  fun processRep(env: Env, monChemin: String, forcage: Bool, memoireLibreP: USize, nbDeMegasLusP: USize, animnumP: USize, moncompeurP: U64) : (U8,USize,USize,U64) =>
    

      let monanimation: Array[String] = ["\r[*         ]"; "\r[ *        ]"; "\r[  *       ]"; "\r[   *      ]"; "\r[    *     ]"; "\r[     *    ]"; "\r[      *   ]"; "\r[       *  ]"; "\r[        * ]"; "\r[         *]"]
      var monExitCode: U8 = 0
      var memoireLibre: USize = memoireLibreP
      var nbDeMegasLus: USize = nbDeMegasLusP
      var monRetour: (U8,USize,USize,U64) = (0,0,0,0)
      var animnum: USize = animnumP
      var moncompeur : U64 = moncompeurP

      let caps = recover val FileCaps.>set(FileRead).>set(FileStat) end
    
      try

      let monFilePath = FilePath(env.root as AmbientAuth, monChemin, caps)?

      if not monFilePath.exists() then

        env.out.print("ERREUR : Le r‚pertoire n'existe pas!!!!")
        monExitCode = 1
        env.exitcode(1)
        return (monExitCode, nbDeMegasLus, animnum, moncompeur)

      end

      let monRep: Directory = Directory(monFilePath)?
    

      let mesEntries: Array[String] = monRep.entries()?

      for element in mesEntries.values() do

        let monElement: String = monRep.path.path + "\\" + element
        
        try

          let monFilePath2: FilePath = FilePath(env.root as AmbientAuth, monElement, caps)?
          let monRep2: Directory = Directory(monFilePath2)?


            monRetour = processRep(env, monElement, forcage, memoireLibre, nbDeMegasLus, animnum, moncompeur)
            monExitCode = monRetour._1
            nbDeMegasLus = monRetour._2
            animnum = monRetour._3
            moncompeur = monRetour._4


        else

            let monFilePath2: FilePath = FilePath(env.root as AmbientAuth, monElement, caps)?
            let monFile: File = File.open(monFilePath2)
            var monBuffer :Array[U8] = []

            nbDeMegasLus = nbDeMegasLus + ((monFile.info()?.size)/(1024*1024))

            if (nbDeMegasLus <  memoireLibre) or forcage then

                monBuffer = monFile.read(1024*1024)

                while (monBuffer.size() > 0) do

                  monBuffer.clear()
                  monBuffer.compact()
                  monBuffer = monFile.read(1024*1024)

                  if((moncompeur%100) == 0) then
                    env.out.write((monanimation(animnum)?))
                    animnum = animnum + 1
                    if (animnum > 9) then animnum = 0 end

                  end

                  moncompeur = moncompeur + 1

                end

                monFile.dispose()
                monBuffer.clear()
                monBuffer.compact()

            else

                monFile.dispose()
                monBuffer.clear()
                monBuffer.compact()
                monExitCode = 2
                env.exitcode(2)
                return (monExitCode, nbDeMegasLus, animnum, moncompeur)

            end
            

        end

      end

    end

    (monExitCode, nbDeMegasLus, animnum, moncompeur)




actor Main
  new create(env: Env) =>

    var cheminracine: String = ""
    var maCommande : String = ""
    var monExitCode : U8 = 0
    var memoireLibre: USize = 0
    var nbDeMegasLus: USize = 0
    var monRetour: (U8,USize,USize,U64) = (0,0,0,0)
    var animnum  : USize = 0
    var moncompeur : U64 = 0
    
    if (env.args.size() < 2) or (env.args.size() > 3) then
      env.out.print( Credits.getArgsIncorrects() )
      env.out.print( Credits.getUsage() )
      env.exitcode(1)
      return
    end

      env.out.print( Credits.getBienvenue() )

      try maCommande = env.args(1)? end

      match maCommande

        | "-r" =>
        
            env.out.print("Mise dans la RAM des donn‚es...")
            env.out.print(" ")
            
            try cheminracine = Path.clean( env.args(2)?) end

            memoireLibre = @GetFreePhysMemoire()
            monRetour = Travail.processRep(env, cheminracine, false, memoireLibre, nbDeMegasLus, animnum, moncompeur)

            monExitCode = monRetour._1
            nbDeMegasLus = monRetour._2

            if monExitCode == 0 then

              env.out.print("Donn‚es lues : " + nbDeMegasLus.string() + " MB")
              env.out.print( Credits.getAurevoir() )

            end

            if monExitCode == 2 then

              env.out.print("Apparemment les donn‚es que vous avez indiqu‚es ‚taient plus grandes que la RAM disponible...")
              env.out.print("La mise en m‚moire s'est donc arrˆt‚e avant la fin des donn‚es !")
              env.out.print("Donn‚es lues : " + nbDeMegasLus.string() + " MB")

            end

        | "-f" =>

            env.out.print("Mise dans la RAM des donn‚es sans v‚rification...")
            env.out.print(" ")
            
            try cheminracine = Path.clean( env.args(2)?) end

            memoireLibre = @GetFreePhysMemoire()
            monRetour = Travail.processRep(env, cheminracine, true, memoireLibre, nbDeMegasLus, animnum, moncompeur)

            monExitCode = monRetour._1
            nbDeMegasLus = monRetour._2

            if monExitCode == 0 then

              env.out.print("Donn‚es lues : " + nbDeMegasLus.string() + " MB")
              env.out.print( Credits.getAurevoir() )

            end

            if monExitCode == 2 then

              env.out.print("INFO : les donn‚es qui ont ‚t‚ lues etaient plus grandes que la RAM disponible, c'est pas grave Window gŠre ‡a... :)")
              env.out.print("Donn‚es lues : " + nbDeMegasLus.string() + " MB")

            end


        | "-v" => env.out.print("Version de l'application : " + Credits.getVersion() )
                  env.out.print(" ")


        | "--memoire" => env.out.print("Voici les infos sur la m‚moire de Windows :")
                      env.out.print(" ")
                      env.out.print("RAM totale : " + @GetTotalPhysMemoire().string() + " MB")
                      env.out.print("RAM libre : " + @GetFreePhysMemoire().string() + " MB")
                      env.out.print("Taille totale du fichier de pagination : " + @GetTotalPageFile().string() + " MB")
                      env.out.print("Espace libre du fichier de pagination : " + @GetFreePageFile().string() + " MB")
                      env.out.print("Taille totale de la m‚moire virtuelle : " + @GetTotalVirtualMemory().string() + " MB")
                      env.out.print("Espace libre de la m‚moire virtuelle : " + @GetFreeVirtualMemory().string() + " MB")
                      env.out.print("Espace libre de la m‚moire virtuelle ‚tendue : " + @GetFreeExtVirtualMem().string() + " MB")
                      env.out.print(" ")
                      env.out.print("Pourcentage de RAM utilis‚e : " + @GetPourcentUse().string() + " % soit " + (100 - @GetPourcentUse() ).string() + " % de libre" )
                      env.out.print(" ")

        | "--credits" =>  env.out.print( Credits.getPony() )
                          env.out.print( Credits.getCredits() )

        else

            env.out.print(Credits.getUsage())

      end


    env.out.print("Fin du programme...!")