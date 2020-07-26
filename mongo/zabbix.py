from pymongo import MongoClient
from sys import argv
import os
import subprocess
#vars for Mongo
HOST = 'mongodb://####USERNAME####:####PASSWORD####@####HOST_IP####:27017/admin'
USER = ####USERNAME####
PASSWORD = ####PASSWORD####
hostname = ####HOSTNAME####

def mongo_connect(HOST,USER,PASSWORD):
    client,db = 0,0 
    try:
        client = MongoClient(host = HOST)
        db = client.data
        db.authenticate(USER,PASSWORD)
        client.close()
    except:
        test = 0
        
            
    return(db) 

def get_server_status(db):
    if db!=0:
        try:
            data = db.command({"serverStatus":1})
            db.logout()
            return(data)
        
        except:
            return('<Not successful command>')
    else:
        return('<Not successful connect to DataBase>')

def get_val(data,val):
    keys = []
    if type(data) == str:
        return(data)
    elif type(data) == dict:
        val = val.split('.')
        for i in val:
            i = i.rstrip().lstrip()
            if i !='' and i in data:
                data = data[i]
            else:
                return('<{i} - invalid key>'.format(i=i))
        return(data)
    else:
        return(data)

def check_vars_file(file):
    vals = []
    if os.path.exists(file):
        if os.path.isfile(file):
            try:
                f = open(file,'r')
                lines = f.readlines()
            except:
                return(0,'<Unreadable file: {file}>'.format(file=file))
            for i in lines:
                if i!='':
                    temp = i.split('\t')
                    if len(temp)==1:
                        vals.append(temp[0].rstrip().lstrip())
                    else:
                        return(0,'<Incorrect data in file: {file} value {temp}>'.format(file=file,temp=temp))
    if len(vals) == 0:
        return(0,'<Incorrect data in file: {file} file is empty>'.format(file=file))
    else:
        return(1,vals)
                
                

def chk_args(argv):
    key = ['out=','vars=','command=','names=']
    keys = {'out':str(argv[0])+'.out','command':''}
    for i in range(1,len(argv)):
        if argv[i] == '/?':
            print('''use the next command to get static:
python <script name> [out=<output file>] vars=<file name> command="<command>" names = <text>\n
where:
out= - path to output file (default if <script name>.out
vars= - file with field of database you wont to get
names= - rpefix to output fields name maby any text
command= - command to execute aftef collecting data (it's empty as default)''')
            exit()
        for j in key:
            if argv[i].find(j)!=-1:
                keys[j.replace('=','')]=argv[i].replace(j,'')

    if 'vars' not in keys:
        print('<No Value File\nscript will be exit>')
        exit()
    if 'names' not in keys:
        print('<Unknow how to name exit-data please check the "names=" tag>')
        exit()        
    else:
        print('params is OK')
        err, vals = check_vars_file(keys['vars'])
        if err == 0:
            print(vals)
            exit()
        else:
            print('Vars file is ok')
            #for i in keys:
                #print('{key} {value}'.format(key = i,value=keys[i]))
            return(vals,keys)
        
def main():
    if len(argv)<2:
        print('<Check arguments>')
    else:
        text = {}
        vals,keys = chk_args(argv)
        db = mongo_connect(HOST,USER,PASSWORD)
        data = get_server_status(db)
        for i in vals:
            text[i] =get_val(data,i)
        f = open(keys['out'],'w')
        for i in text:
            f.write('{host} {word}.{key} {value}\n'.format(host = hostname, word = keys['names'],key=i,value=text[i]))
        f.close()
        if keys['command']!='' and keys['command']!=None:
            try:
                p = subprocess.Popen(keys['command'], shell = True, stdout = subprocess.PIPE)
                s = ' '
                while s:
                    s = p.stdout.readline()
                    print(s)
            except:
                print('Error in running CMD')
        exit()
        
if __name__ == "__main__":
    main()
    #chk_args(argv)


