import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { GeorgefloydComponent } from './georgefloyd.component';

describe('GeorgefloydComponent', () => {
  let component: GeorgefloydComponent;
  let fixture: ComponentFixture<GeorgefloydComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ GeorgefloydComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GeorgefloydComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
