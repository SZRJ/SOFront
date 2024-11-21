import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    FormsModule
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})

export class LoginComponent {
  email: string = '';
  password: string = '';

  constructor(private http: HttpClient, private router: Router) { }

  login() {
    // Mostrar en consola que la solicitud se está enviando
    console.log('Enviando solicitud de login...');
    console.log(`Email: ${this.email}, Password: ${this.password}`);

    this.http.post('http://cranky_bouman:3000/Users/login', { email: this.email, password: this.password })
      .subscribe({
        next: (response) => {
          // Si la respuesta es exitosa, redirige al home
          console.log('Conexión exitosa:', response);
          this.router.navigate(['/home']);
        },
        error: (err) => {
          // Si hay un error, muestra el mensaje en consola
          console.error('Error en la solicitud:', err);
          alert('Credenciales incorrectas');
        },
      });
  }
}
