 # This program simulates a roulette wheel.
 # The program asks the user to input
 # the value of their bank and then asks for the
 # amount they wish to gain. Then the program asks the user
 # to input the value of their bet and the color they wish
 # to bet on. 
 # Then the program simulates the spinning of the roulette wheel
 # and produces a winning color which is compared with the users bet.
 # The appropriate calculations are then done based on whether
 # the user won or lost. 
 #
 # Date::     02/08/2014
 # Modified by Qhorin on 2/22/2014

 # This class holds the constuctor for the roulette slots.
 # slotColor:: holds the value of the slot's color
 # slotNumber:: holds the value of the slot's number
class Slot
  attr_accessor :slotColor, :slotNumber
  
  #Initializes the color and number of a slot
  def initialize(slotColor, slotNumber)
   @slotColor = slotColor
   @slotNumber = slotNumber
   
  end
 
end

# This class contains the constuctor for creating the wheel
# and the slots on the wheel. It also contains methods for the
# simulation of the betting process and the start of the game
# slotArray:: the array in which all slots on the wheel are contained
# isDoublingUp:: used to determine if the user is currently using the
#                the double up strategy.
class Wheel
  @@slotArray
  @@isDoublingUp = false
  
  # This method initializes the wheel object and creates
  # the slots.
  # @wheelName:: Holds the Wheels name
  # @@slotArray:: contains the Slot objects
  def initialize(wheelName)
    @wheelName = wheelName
    @@slotArray = [Slot.new("Red","1"),Slot.new("Black","2"),Slot.new("Red","3"),Slot.new("Black","4"),
                   Slot.new("Red","5"),Slot.new("Black","6"),Slot.new("Red","7"),Slot.new("Black","8"),
                   Slot.new("Red","9"),Slot.new("Black","10"),Slot.new("Black","11"),Slot.new("Red","12"),
                   Slot.new("Black","13"),Slot.new("Red","14"),Slot.new("Black","15"),Slot.new("Red","16"),
                   Slot.new("Black","17"),Slot.new("Red","18"),Slot.new("Red","19"),Slot.new("Black","20"),Slot.new("Red","21"),
                   Slot.new("Black","22"),Slot.new("Red","23"),Slot.new("Black","24"),Slot.new("Red","25"),
                   Slot.new("Black","26"),Slot.new("Red","27"),Slot.new("Black","28"),Slot.new("Black","29"),
                   Slot.new("Red","30"),Slot.new("Black","31"),Slot.new("Red","32"),Slot.new("Black","33"),
                   Slot.new("Red","34"),Slot.new("Black","35"),Slot.new("Red","36"),Slot.new("Green","0"),
                   Slot.new("Green","00")]
    
  end
    
  # This method simulates the spinning wheel.
  # A random number generator is used to select the winning slot.
  # return:: returns the Slot object of the @@slotArray at the randomNums location.
   def self.spinWheel()
     randomNum = rand(38)
     return @@slotArray[randomNum]     

   end
   
   # This method allows the user to place a bet.
   # This method also determines if the user won or lost.
      def self.placeBet(baValue, baMax)
  
     while(baValue.to_i > 0 && baValue.to_i < baMax.to_i)
       if(@@isDoublingUp == false)
         puts "Enter Value of Bet:"
         betValue = gets.chomp
         betValue.to_i
       end
       puts "Enter Color of Bet:"
       betColor = gets.chomp
            
       winningSlot = spinWheel()
       slotColor = winningSlot.slotColor
       puts (winningSlot.slotColor + " " + winningSlot.slotNumber)
       
       if(betColor.downcase.eql? slotColor.downcase)
         puts "You win!"
         baValue = baValue.to_i + betValue.to_i
         @@isDoublingUp = false
         puts "Bank value = #{baValue}"
         if (baValue.to_i == baMax.to_i)
           puts "Congratulations, you have reached your goal!"
         end
       else
         puts "You Lose!"
         baValue = baValue.to_i - betValue.to_i
         puts "Bank value = #{baValue}"

         # This if checks to see if the previous bet was $1
         # if so, the user is asked if they would like to double up
         # If the user is currently doubling up, then the user is not
         # asked if they want to double up, but the previous betValue is doubled.
         if((betValue.to_i == 1 || @@isDoublingUp == true) && baValue.to_i >= betValue.to_i)
           if(@@isDoublingUp != true)
           answer = doubleUp
           end
           if(answer == "y" && baValue.to_i > 0)
             betValue = betValue.to_i * 2
             puts "Current Bet Value = #{betValue}"
             @@isDoublingUp = true
           else
             @@isDoublingUp = false
           end
           
         end
         if(baValue < 1)
          puts "Oh no! You have run out of money!" 
         end
       end
    end
   end
   
   # This methods initializes the users bank total
   # and the value they user wishes their bank to meet.
   # bankValue:: Current value of the user's bank
   # bankMax:: the value the user wishes their bank to meet.
   def self.startGame
     puts "How much money would you like to put in your bank?"
     bankValue = gets.chomp
     bankValue.to_i
     puts "Enter desired bank total:"
     bankMax = gets.chomp
     bankMax.to_i
     while(bankMax.to_i <= bankValue.to_i)
       puts "Bank max must be greater than current bank total!"
       puts "Enter desired bank total:"
       bankMax = gets.chomp
       bankMax.to_i
     end
     placeBet(bankValue, bankMax)
   end
   
   # This method simply asks if the user wishes to double up
   # after a bet of $1 has been lost. 
   # return: y or n
   def self.doubleUp()
     puts "Would you like to double up? y or n"
     answer = gets.chomp
     if (answer.downcase == "y")
        return "y"
     else
       return "n"
     end
   end
     
   #initializes the wheel object
   myWheel = Wheel.new("Routlette")
   # Starts the game
   startGame
     
end