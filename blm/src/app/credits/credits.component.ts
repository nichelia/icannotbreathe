import { Component } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatBottomSheet, MatBottomSheetRef } from '@angular/material/bottom-sheet';

/**
 * @title Bottom Sheet Overview
 */
@Component({
  selector: 'bottom-sheet-credits',
  templateUrl: './bottom-sheet-credits.html',
  styleUrls: ['./bottom-sheet-credits.css'],
})
export class BottomSheetCreditsComponent
{

  constructor(private _bottomSheetRef: MatBottomSheetRef<BottomSheetCreditsComponent>) {}

  openLink(event: MouseEvent): void {
    this._bottomSheetRef.dismiss();
  }

}

@Component({
  selector: 'app-credits',
  templateUrl: './credits.component.html',
  styleUrls: ['./credits.component.css']
})
export class CreditsComponent
{

  constructor(private _bottomSheet: MatBottomSheet) {}

  openBottomSheet(): void {
    this._bottomSheet.open(BottomSheetCreditsComponent);
  }

}
