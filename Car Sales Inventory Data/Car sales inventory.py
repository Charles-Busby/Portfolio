#This is Programm will fill the requirements fo the final projct
    #for Basic Programming at CSU Global

#********************************
#The following section will import the needed library
#********************************

from tkinter import *
#Import the tinkiter library
from tkinter import Tk
from tkinter.filedialog import askopenfilename
#imports the download file module from tinkter
import getpass
#This will get teh needed libriary for the users namespace

Inventory=[]
Vehicle ={}

#***********************************
#This section will define the function main function
#***********************************
    
class MENU():
#creates the GUI Class
    def Save():
        #creates the function to save the inventory
        Inputs.save_file()

    def New_Vehicle():
        #create the function for the new vehicle input
        Inputs.New_input()
    
    def OpenFile():
        #creates the function to import an existing file
        Inputs.open_file()

    def Edit_Vehicle():
        #Creates the function to edit the inventory
        Inputs.List()

#********************************
#The following section create the GUI
#********************************
        
class GUI():
    #creates the gui class
    def Window():
        #creates teh method for the new GUI Window
        root = Tk()
        #labels the new TK window
        root.title("Auto Dealer Inventory")
        #creates the title for the new window
        root.geometry('350x200')
        #dictates the size of the new window
        lbl = Label(root, text="Please select your actions from the menu")
        #tell the user what the window is for
        lbl.grid(column=0,row=0)
        #places the new text in the window
        menu = Menu(root)
        #Create the menu for teh window
        root.config(menu=menu)
        #adds the drop down menu to the window
        filemenu =Menu(menu)
        #labels teh menu
        menu.add_cascade(label="File", menu=filemenu)
        #Creates the cascade
        filemenu.add_command(label="New Vehicle",command=MENU.New_Vehicle)
        #Adds the ability to create a new vehicle
        filemenu.add_command(label="Import Existing List", command=MENU.OpenFile)
        #Adds the Import function to the menu
        filemenu.add_command(label="Edit Existing Vehicle", command=MENU.Edit_Vehicle)
        #adds the ability to exit the program
        filemenu.add_command(label="Save Inventory", command=MENU.Save)
        #adds the ability to exit the program
        mainloop()

#***********************************
#This section will Create the Actions for the user inputs
#***********************************
class Inputs():

    def New_input():
        global Inventory
        #This will create the new vehicle information form
        fields = ('Make', 'Model', 'Color','Year', 'Price', 'Miles')
        #This defines the fields for the form
        def New(root, fields):
#This creates the form
            entries = {}
#This creates the dictionary for the entry
            for field in fields:
#This creates the text and the input boxes for the
                row = Frame(root)
#this creates row for each entry
                lab = Label(row, width=22, text=field + ": ", anchor='w')
#This creates the label for each entry
                ent = Entry(row)
#This creates the the entry boxes
                ent.insert(0, "0")
#Places the entry box on the new window
                row.pack(side=TOP, fill=X, padx=5, pady=5)
#adjust teh box size to fit the window
                lab.pack(side=LEFT)
#Places teh labels on the left side of the new screen
                ent.pack(side=RIGHT, expand=YES, fill=X)
#Places the entry boxes on the right side of the new screen
                entries[field] = ent
#sends the entries to a list
            return entries
        #Ends the program and returns all of the entries from the form
        def Submit(entries):
            #This will create the submit button
            Make = str(entries['Make'].get())
            #Gets the information for the MAke of the Vehicle
            Model = str(entries['Model'].get())
            #Gets the information for the model of the vehicle
            Color = str(entries['Color'].get())
            Year = int(entries['Year'].get())
            #Gets the year of the vehicle
            Price = int(entries['Price'].get())
            #Gets the price of the Vehicle
            Miles = int(entries['Miles'].get())
            #Gets the miles of the vehicles
            Vehicle = {'Make': Make,
                       'Model': Model,
                       'Year': Year,
                       'Price': Price,
                       'Miles': Miles}
            #Places all of the information in a dictionary
            Inventory.append(Vehicle)
            #Places the dictionary in the inventory list
            return Inventory
            #ends the function and returns the new inventory list
        root = Tk()
        #Creates the window from Tkinter
        root.title("New Vehicle Entry")
        #Changes the title of the window
        ents = New(root, fields)
        #labels the fields ents
        root.bind('<Return>', (lambda event, e = ents: fetch(e)))
        #binds the events from the new window
        b1 = Button(root, text = 'Submit', command = (lambda e=ents: Submit(e)))
        #Creates the submit button
        b1.pack(side=LEFT, padx=5, pady=5)
        #Places the submit button on the new window
        b2 = Button(root, text='Quit', command=root.destroy)
        #Creartes the quit button
        b2.pack(side=LEFT, padx=5, pady=5)
        #Places the quit button ont he screen

    def List():
        #this is the funtion that will create the list box
        root: Tk = Tk()
        #Creates the tkinter frame
        root.title("Auto Dealer Inventory selector")
        #titels teh frame
        root.geometry('400x200')
        #sizes the frame
        scrollbar = Scrollbar(root)
        #Creates the verticle scroll bar
        hbar = Scrollbar(root, orient = HORIZONTAL)
        #creates the horizontl scrollbar
        scrollbar.pack(side = RIGHT, fill = Y)
        #Places the verticle scrollbar
        hbar.pack(side = BOTTOM, fill = X)
        #Places the horizontal scrollbar
        listbox = Listbox(root, yscrollcommand = scrollbar.set, xscrollcommand = hbar.set, selectmode = SINGLE)
        #Creates the listy box and makes the items selectable
        #Gets the items to places in the listbox
        for item in Inventory:
            #Creates a loop to place all items from the inventory in the listbox
            listbox.insert(END, item)
            #Places the item in the listbox
        listbox.pack(side = LEFT, fill = BOTH)
        #Places the listbox in the new window
        scrollbar.config(command = listbox.yview)
        #Creates the ability to verticle scroll
        hbar.config(command = listbox.xview)
        #Creates the abiltity to horizontally scroll
        def change():
            #Creats the function to change an entry
            sel = listbox.curselection()
            #Gets teh item that is selected
            if len(sel) > 0:
                #Chaecks to make sure that an item is selected.
                indexToEdit = Inventory.index(eval(listbox.get(sel[0])))
                #select the item to edit
                listbox.delete(sel)
                #Delet the old item
                root.wait_window(Inputs.New_input())
                #Opens up the new input window
                listbox.insert(sel, Inventory[indexToEdit])
                #inputs the item that was corrected
        def Delete():
            #This function will create the ability to delet a portion of the inventory
            sel = listbox.curselection()
            #allows the user to slecet the item to be deleted
            listbox.delete(sel)
            #Delets the item
        B2 = Button(root, text = "Delete", command = Delete).pack()
        #This will create the delet button
        B1 = Button(root, text = "Edit", command = change).pack()
        #Creates the edit button and places it on the screen
        mainloop()
        #This will finalize the screen

    def open_file():
        #This will allow the user to open an existing file and import it to the inventory list
        global Inventory
        #Getst the list
        filename = askopenfilename(title='Select File')
        #Ask the user to select the file to open
        with open(filename, 'r') as inf:
        #Creates a loop for the open fill
            for line in inf:
                #Creates a loop for all of the lines in the file
                Vehicle = eval(line)
                #Creates a dictionary for each line that is oppened
                Inventory.append(Vehicle)
                #Adds the imported dictionaries to to the Inventory list
        return  Inventory
        #Ends the function and returns teh updated inventory list

    def save_file():
        #This will allow the user to save the function
        Name = getpass.getuser()
        #This gets the user name
        FilePath = r'C:/Users/' + Name + '/Desktop/Dealership_Inventory.txt'
        #this develops the path to save the function
        with open(FilePath, "w") as output:
            #Creats a loop  to write the list
            for i in range(len(Inventory)):
                #Creates a loop for every dictionary in the list
                print_string = ''
                #Creats the string variable to save
                print_string = str(Inventory[i])
                #Updates the string variable to equal the dictionary
                print_string += '\n'
                #adds the need for a new line at the end of the variable
                output.write(print_string)
                #Writes the string on the txt file

#***********************************
#This section will define the function main function
#***********************************
def main():
    #This will call the main program
    GUI.Window()

#***********************************
#This section will call the function main function
#***********************************
if __name__=='__main__':main()
    #This calls teh main function