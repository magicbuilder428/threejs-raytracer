/* global THREE */

THREE.CameraDragControls = function ( object, domElement ) {

	this.object = object;

	this.domElement = ( domElement !== undefined ) ? domElement : document;

	this.enabled = true;

	this.lookSpeed = 0.005;
	this.lookVertical = true;	

	this.mouseX = 0;
	this.mouseY = 0;
  this.deltaX = 0;
  this.deltaY = 0;
  
  this.horizontalAngle = 3.14;
  this.verticalAngle = 0;

	this.mouseDragOn = false;

	this.viewHalfX = 0;
	this.viewHalfY = 0;

	if ( this.domElement !== document ) {

		this.domElement.setAttribute( 'tabindex', - 1 );

	}

	//

	this.handleResize = function () {

		if ( this.domElement === document ) {

			this.viewHalfX = window.innerWidth / 2;
			this.viewHalfY = window.innerHeight / 2;

		} else {

			this.viewHalfX = this.domElement.offsetWidth / 2;
			this.viewHalfY = this.domElement.offsetHeight / 2;

		}

	};

	this.onMouseDown = function ( event ) {
		if ( this.domElement !== document ) {

			this.domElement.focus();

		}

		event.preventDefault();
		event.stopPropagation();

    if (!this.mouseDragOn){
		  this.mouseDragOn = true;
      // remember current mouse position
      if ( this.domElement === document ) {

        this.mouseX = event.pageX - this.viewHalfX;
        this.mouseY = event.pageY - this.viewHalfY;

      } else {

        this.mouseX = event.pageX - this.domElement.offsetLeft - this.viewHalfX;
        this.mouseY = event.pageY - this.domElement.offsetTop - this.viewHalfY;

      } 
    }    
	};

	this.onMouseUp = function ( event ) {

		event.preventDefault();
		event.stopPropagation();

		this.mouseDragOn = false;
    this.deltaX = 0;
    this.deltaY = 0;
	};

	this.onMouseMove = function ( event ) {
    // calculate moved position
    if (this.mouseDragOn){
      let newX,newY;  
      if ( this.domElement === document ) {

          newX = event.pageX - this.viewHalfX;
          newY = event.pageY - this.viewHalfY;

      } else {

          newX = event.pageX - this.domElement.offsetLeft - this.viewHalfX;
          newY = event.pageY - this.domElement.offsetTop - this.viewHalfY;

      } 
      this.deltaX = newX - this.mouseX;
      this.deltaY = newY - this.mouseY;
    }
    
	};


	this.update = function ( delta ) {

		if ( this.enabled === false ) return;
  
    if (this.mouseDragOn){
      this.horizontalAngle += this.lookSpeed * delta * this.deltaX;
      this.verticalAngle += this.lookSpeed * delta * this.deltaY;

      
    }
  
  }
  
	function contextmenu( event ) {

		event.preventDefault();

	}

	this.dispose = function () {
		this.domElement.removeEventListener( 'contextmenu', contextmenu, false );
		this.domElement.removeEventListener( 'mousedown', _onMouseDown, false );
		this.domElement.removeEventListener( 'mousemove', _onMouseMove, false );
		this.domElement.removeEventListener( 'mouseup', _onMouseUp, false );

	};

	var _onMouseMove = bind( this, this.onMouseMove );
	var _onMouseDown = bind( this, this.onMouseDown );
	var _onMouseUp = bind( this, this.onMouseUp );

	this.domElement.addEventListener( 'contextmenu', contextmenu, false );
	this.domElement.addEventListener( 'mousemove', _onMouseMove, false );
	this.domElement.addEventListener( 'mousedown', _onMouseDown, false );
	this.domElement.addEventListener( 'mouseup', _onMouseUp, false );



	function bind( scope, fn ) {

		return function () {

			fn.apply( scope, arguments );

		};

	}

	this.handleResize();

};