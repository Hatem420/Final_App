import 'package:flutter/material.dart' ;

class AuthFrom extends StatefulWidget{

  final void Function(String email,String password, String username,
      bool islogin,BuildContext ctx) submitFn ;


  final bool _isloading ;
  AuthFrom(this.submitFn,this._isloading);
  @override
  _AuthFromState createState() => _AuthFromState();
}

class _AuthFromState extends State<AuthFrom>{
  final _formkey =GlobalKey<FormState>();
  bool _islogin = true ;
  String _email="" ;
  String _password = "" ;
  String _username ="" ;

  void _submit(){
    final isValid =_formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formkey.currentState.save();
      widget.submitFn(_email.trim(),_password.trim(),_username.trim(),_islogin,context);
    }
  }
  @override
  Widget build(BuildContext context){
    return Center(
      child: Card(
        margin:EdgeInsets.all(20),
        child:SingleChildScrollView(
          padding:EdgeInsets.all(16),
          child:Form(
            key:_formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (val){
                    if(val.isEmpty || !val.contains('@')){
                      return 'please enter a valid email address';
                    }
                    return null ;
                  },
                  onSaved: (val) => _email = val ,
                  keyboardType: TextInputType.emailAddress ,
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
                if(!_islogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val){
                      if(val.isEmpty || val.length < 4){
                        return "please enter at least 4 characters" ;
                      }
                      return null ;
                    },
                    onSaved: (val) => _username = val ,
                    decoration: InputDecoration(labelText: "username"),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val){
                    if(val.isEmpty || val.length < 4){
                      return "password must be at least 4 charachter" ;
                    }
                    return null ;
                  },
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "password"),
                  obscureText: true,
                ),
                SizedBox(height: 12),
                if(widget._isloading)
                  CircularProgressIndicator(),
                if(!widget._isloading)
                  RaisedButton(
                    child: Text(_islogin ? 'Login' : 'Sign Up'),
                    onPressed: _submit,
                  ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(_islogin
                      ? 'Create new account'
                      :'I already have an account'
                  ),
                  onPressed: (){
                    setState((){
                      _islogin = !_islogin ;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}