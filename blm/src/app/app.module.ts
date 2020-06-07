import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { FlexLayoutModule } from '@angular/flex-layout';
import { MatButtonModule } from '@angular/material/button';
import { MatBottomSheetModule } from '@angular/material/bottom-sheet';
import { MatListModule } from '@angular/material/list';

import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { GeorgefloydComponent } from './georgefloyd/georgefloyd.component';
import { CreditsComponent, BottomSheetCreditsComponent } from './credits/credits.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    GeorgefloydComponent,
    CreditsComponent,
    BottomSheetCreditsComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    FlexLayoutModule,
    MatButtonModule,
    MatBottomSheetModule,
    MatListModule,
  ],
  entryComponents: [
    CreditsComponent,
    BottomSheetCreditsComponent,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
